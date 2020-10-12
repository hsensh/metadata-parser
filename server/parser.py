import os
import json
import mysql.connector
import requests

from flask import Flask, request, redirect, url_for, send_from_directory
from flask_cors import CORS

from lxml import html
import win32com.client

from pptx import Presentation
from datetime import datetime
from exif import Image


app = Flask(__name__)
CORS(app)

def map_powerpoint_metas():
    sh = win32com.client.gencache.EnsureDispatch("Shell.Application", 0)
    powerpoints_metas = []
    ns = sh.NameSpace(os.path.abspath("static/powerpoints"))

    colnum = 0
    columns = []
    while True:
        colname = ns.GetDetailsOf(None, colnum)
        if not colname:
            break
        columns.append(colname)
        colnum += 1

    for item in ns.Items():
        powerpoint_metas = {}
        f = open(os.path.abspath(f"static/powerpoints/{item}"), "rb")
        prs = Presentation(f)
        f.close()

        powerpoint_metas["Slide Number"] = len(prs.slides)
        for index, column in enumerate(columns):
            if column in ["Title", "Categories", "Size", "Authors"]:
                powerpoint_metas[column] = ns.GetDetailsOf(item, index)
        if powerpoint_metas:
            powerpoints_metas.append(powerpoint_metas)

    return powerpoints_metas


powerpoints_metas = map_powerpoint_metas()


@app.route('/get_images')
def get_images():
    response = []
    image_names = os.listdir('static/images')
    
    for image_name in image_names:
        with open(f"static/images/{image_name}", "rb") as image_file:
            image = Image(image_file)
        response.append(
            {
                'path': f'static/images/{image_name}',
                'model': image.model if image.has_exif else None,
                'lens': image.lens_model if image.has_exif else None
            }
        )
    return app.response_class(mimetype='application/json', response=json.dumps(response))



@app.route("/insert_link_metas", methods=["POST"])
def insert_link_metas():
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password="root",
        database="testdb",
        auth_plugin="mysql_native_password",
    )
    link = request.get_json()["link"]
    page = requests.get(link)
    tree = html.fromstring(page.content)
    metas = tree.xpath("//meta")

    cursor = db.cursor()
    sql = "INSERT INTO links (value) VALUES (%s)"
    values = (link,)
    cursor.execute(sql, values)
    link_id = cursor.lastrowid
    for meta_id, meta in enumerate(metas):
        sql = "INSERT INTO metas (value, link_id) VALUES (%s, %s)"
        meta_name = f"meta{meta_id}"
        values = meta_name, link_id
        cursor.execute(sql, values)
        meta_id = cursor.lastrowid

    for attrib_key in meta.attrib.keys():
        sql = "INSERT INTO pairs (meta_key, value, meta_id) VALUES (%s, %s, %s)"
        values = attrib_key, meta.attrib[attrib_key], meta_id
        cursor.execute(sql, values)

    db.commit()
    db.close()
    return app.response_class(status=200, mimetype="application/json")


@app.route("/get_metas")
def get_metas():
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password="root",
        database="testdb",
        auth_plugin="mysql_native_password",
    )
    cursor = db.cursor()
    cursor.execute("SELECT * FROM links")

    result = cursor.fetchall()
    links = []
    for row in result:
        metas = []
        cursor.execute(
            f"SELECT * FROM metas WHERE link_id = '{row[0]}'",
        )
        meta_result = cursor.fetchall()
        for meta_row in meta_result:
            cursor.execute(f"SELECT * FROM pairs WHERE meta_id = '{meta_row[0]}'")
            pair_result = cursor.fetchall()
            for pair_row in pair_result:
                metas.append(
                    {
                        "key": pair_row[1].decode() if type(pair_row[1]) != str else pair_row[1],
                        "value": pair_row[2].decode() if type(pair_row[2]) != str else pair_row[2]}
                )

        links.append({"link": row[1].decode() if type(row[1]) != str else row[1], "metas": metas})
    db.close()
    return app.response_class(
        mimetype="application/json", status=200, response=json.dumps(links)
    )


@app.route("/get_powerpoint_metas")
def get_powerpoint_metas():
    return app.response_class(
        mimetype="application/json",
        status=200,
        response=json.dumps(powerpoints_metas),
    )


@app.route("/upload_powerpoint", methods=["GET", "POST"])
def upload_powerpoint():
    if request.method == "POST":
        if "file" not in request.files:
            response = json.dumps(
                {"BAD_REQUEST": "parameter 'file' is missing from the form request"}
            )
        uploaded_file = request.files["file"]
        if uploaded_file.filename == "":
            response = json.dumps({"BAD_REQUEST": "no file uploaded"})
        if uploaded_file:
            file_path = os.path.abspath(
                "static/powerpoints/" + uploaded_file.filename + datetime.now().microsecond
            )
            uploaded_file.save(file_path)
    return app.response_class(status=200, mimetype="application/json")


if __name__ == "__main__":
    app.run(debug=True)
