import React, { useEffect } from "react";
import "./App.css";
import MaterialTable from "material-table";
import axios from "axios";

function Modal(props) {
  return (
    <div
      onClick={() => props.closeModal()}
      style={{
        display: props.open ? "flex" : "none",
        position: "fixed",
        zIndex: "999",
        background: "rgb(0, 0, 0, 0.5)",
        width: "100%",
        height: "100%",
        justifyContent: "center",
        overflow: "auto",
      }}
    >
      <div
        key={props.image.path}
        style={{
          width: "20%",
          boxShadow: "4px 4px 10px #888",
          margin: "1%",
          display: "flex",
          height: "fit-content",
          justifyContent: "center",
          flexDirection: "column",
          alignItems: "center",
          padding: "2%",
          borderRadius: "3px",
          background: "white",
        }}
      >
        <div
          style={{
            height: "20%",
            width: "100%",
            background: "black",
            display: "flex",
            justifyContent: "center",
            alignItems: "center",
            overflow: "hidden",
          }}
        >
          <img
            src={`http://localhost:5000/${props.image.path}`}
            style={{ height: "200px", maxWidth: "100%" }}
          />
        </div>

        <div
          style={{
            textAlign: "left",
            margin: "0 auto",
            height: "35%",
            width: "100%",
            marginTop: "4%",
          }}
        >
          {Object.keys(props.image).map((key) => {
            key = key
              .replace(/([A-Z])/g, " $1")
            key = key.charAt(0)
              .toUpperCase() + key.slice(1);
            return (
              <div>
                <strong style={{ paddingRight: "10px" }}>
                  {key}
                </strong>
                <span style={{ display: "block" }}>
                  {props.image[key] || "Not Specified"}
                </span>
              </div>
            )
          })}
        </div>
      </div>
    </div>
  );
}

export default Modal;
