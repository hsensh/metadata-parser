import React, { useEffect } from "react";
import "./App.css";
import MaterialTable from "material-table";
import axios from "axios";

function App() {
  const [htmlMetadata, setHtmlMetadata] = React.useState([]);
  const [powerpointMetadata, setPowerpointMetadata] = React.useState([]);
  const [images, setImages] = React.useState([]);

  const getValues = () => {
    axios
      .get("http://localhost:5000/get_metas")
      .then((response) => {
        setHtmlMetadata(response.data);
      })
      .catch((err) => console.log(err));

    axios
      .get("http://localhost:5000/get_powerpoint_metas")
      .then((response) => {
        setPowerpointMetadata(response.data);
      })
      .catch((err) => console.log(err));
    
    axios.get("http://localhost:5000/get_images")
      .then(response => {
        setImages(response.data);
      })
    .catch(err => console.log(err))
  };

  useEffect(() => {
    getValues();
  }, []);

  let htmlColumns = [
    {
      title: "Link",
      field: "link",
    },
    {
      title: "Metas",
      render: (row) => {
        return (
          <div>
            {row.metas.map((element, index) => {
              return (
                <div
                  key={index}
                  style={{
                    margin: "20px",
                    display: "grid",
                    gridTemplateColumns: "1fr 4fr",
                  }}
                >
                  <span
                    style={{
                      margin: "5px",
                      textAlign: "center",
                      padding: "5px",
                      border: "1px solid lightblue",
                      background: "lightblue",
                      color: "white",
                      borderRadius: "10px",
                      width: "500px"
                    }}
                  >
                    {element.key}
                  </span>
                  <span
                    style={{
                      margin: "5px",
                      padding: "5px",
                      border: "1px solid lightgreen",
                      background: "lightgreen",
                      color: "white",
                      borderRadius: "10px",
                    }}
                  >
                    {" "}
                    {element.value}
                  </span>
                </div>
              );
            })}
          </div>
        );
      },
    },
  ];
  let powerpointColumns = [
    {
      title: "Title",
      field: "Title",
    },
    {
      title: "Categories",
      field: "Categories",
    },
    {
      title: "Authors",
      field: "Authors",
    },
    {
      title: "Size",
      field: "Size",
    },
    {
      title: "Slide Number",
      field: "Slide Number",
    },
  ];
  return (
    <div className="App">
      <div
        style={{
          width: "92%",
          margin: "20px 1%",
          background: "white",
          borderRadius: "5px",
          color: "black",
          boxShadow: "4px 4px 10px #888",
          minHeight: "100px",
          padding: "3%",
          display: "flex",
          flexWrap: "wrap",
          justifyContent: "center"
        }}
      >
        {images &&
          images.map((image) => (
            <div
              key={image.path}
              style={{
                width: "20%",
                boxShadow: "4px 4px 10px #888",
                margin: "1%",
                display: "flex",
                justifyContent: "center",
                flexDirection: "column",
                alignItems: "center",
                padding: "2%",
                borderRadius: "3px"
              }}
            >
              <div style={{ height: "60%", width: "100%", background: "black", display: "flex", justifyContent: "center", alignItems: "center", overflow: "hidden" }}>
                <img
                src={`http://localhost:5000/${image.path}`}
                style={{ height: "200px", maxWidth: "100%" }}
                />
              </div>
              
              <div style={{textAlign: "left", margin: "0 auto", height: "35%", width: "100%", marginTop: "4%"}}>
                <strong style={{paddingRight: "10px"}}>Camera</strong>
                <span style={{ display: 'block' }}>
                  {image.model || 'Not Specified'}
                </span>
               <strong style={{paddingRight: "10px"}}>Lens</strong>
                <span style={{display: 'block'}}>
                  {image.lens || 'Not Specified'}
                </span>
              </div>
            </div>
          ))}
      </div>
      <MaterialTable
        title="URL Metadata"
        data={htmlMetadata}
        columns={htmlColumns}
        style={{ margin: "10px", boxShadow: "4px 4px 10px #888" }}
      ></MaterialTable>
      <MaterialTable
        title="Powerpoint Metadata"
        data={powerpointMetadata}
        columns={powerpointColumns}
        style={{ margin: "10px", boxShadow: "4px 4px 10px #888" }}
      ></MaterialTable>
    </div>
  );
}

export default App;
