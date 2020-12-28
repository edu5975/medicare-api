const axios = require('axios');

async function getAxios(url) {
    var datos = JSON;
    await axios.get(url)
        .then(function(response) {
            datos = response.data;
        })
        .catch(function(error) {
            console.log(error);
        })
        .then(function() {});
    return datos;
}

async function postAxios(url, data = null) {
    var datos = JSON;
    await axios.post(url, data)
        .then(function(response) {
            datos = response;
        })
        .catch(function(error) {
            console.log(error);
        })
        .then(function() {});
    return datos;
}

module.exports = {
    getAxios,
    postAxios
};