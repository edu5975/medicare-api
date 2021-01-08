const multer = require('multer');
const mimeTypes = require('mime-types')

const storage = multer.diskStorage({
    destination: function(req, file, cb) {
        cb(null, './src/images')
    },
    filename: function(req, file, cb) {
        url = Date.now() + '.' + mimeTypes.extension(file.mimetype);
        cb(null, url);
        upload.url = url;
    }

})

const upload = multer({ storage })

module.exports = upload;