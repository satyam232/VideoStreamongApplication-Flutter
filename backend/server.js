const express = require('express');
const fs = require('fs');
const rangeParser = require('range-parser');
const mongoose=require('mongoose');
const bodyParser = require('body-parser');
const helmet=require('helmet');
const cors=require('cors');




const app = express();

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: true}));
app.use(helmet());
app.use(cors());


// Import your routes
const userRoutes = require('./routes/userRoutes');
const categoryRoutes = require('./routes/categoryRoutes');

app.use('/category',categoryRoutes);

// Use your routes
app.use('/user', userRoutes);



mongoose.connect('mongodb://0.0.0.0:27017/mydatabase').then(()=>{
    console.log("mongodb is connected");
})




function streamFile(req, res, filePath, contentType) {
  const stat = fs.statSync(filePath);
  const fileSize = stat.size;

  const range = req.headers.range;
  if (range) {
    const parts = rangeParser(fileSize, range);
    if (parts && parts.type === 'bytes') {
      const start = parts[0].start;
      const end = parts[0].end;

      const chunkSize = end - start + 1;
      const file = fs.createReadStream(filePath, { start, end });

      res.writeHead(206, {
        'Content-Range': `bytes ${start}-${end}/${fileSize}`,
        'Accept-Ranges': 'bytes',
        'Content-Length': chunkSize,
        'Content-Type': contentType,
      });

      file.pipe(res);
      return;
    }
  }


  res.writeHead(200, {
    'Content-Length': fileSize,
    'Content-Type': contentType,
  });

  fs.createReadStream(filePath).pipe(res);
}


app.get('/interstaller', (req, res) => {
  const filePath = './movies/interstaller.mkv';
  const contentType = 'video/x-matroska'; 

  streamFile(req, res, filePath, contentType);
});

app.get('/interstaller_img', (req, res) => {
  const filePath = './images/videos_img.jpg';
  const contentType = 'image/jpeg';

  streamFile(req, res, filePath, contentType);
});





app.get('/avatar', (req, res) => {
  const filePath = './movies/avatar.mkv';
  const contentType = 'video/x-matroska'; 

  streamFile(req, res, filePath, contentType);
});

app.get('/avatar_img', (req, res) => {
  const filePath = './images/avatar_img.jpg';
  const contentType = 'image/jpeg';

  streamFile(req, res, filePath, contentType);
});


app.get('/inception', (req, res) => {
    const filePath = './movies/inception.mkv';
    const contentType = 'video/x-matroska'; 
  
    streamFile(req, res, filePath, contentType);
  });
  
  app.get('/inception_img', (req, res) => {
    const filePath = './images/inception_img.jpg';
    const contentType = 'image/jpeg';
  
    streamFile(req, res, filePath, contentType);
  });



//tenet  
app.get('/tenet', (req, res) => {
    const filePath = './movies/tenet.mkv';
    const contentType = 'video/x-matroska';
  
    streamFile(req, res, filePath, contentType);
  });
  
  app.get('/tenet_img', (req, res) => {
    const filePath = './images/tenet_img.jpg';
    const contentType = 'image/jpeg';
  
    streamFile(req, res, filePath, contentType);
  });



app.get('/flash', (req, res) => {
    const filePath = './movies/flash.mkv';
    const contentType = 'video/x-matroska';
  
    streamFile(req, res, filePath, contentType);
  });
  
  app.get('/flash_img', (req, res) => {
    const filePath = './images/flash_img.jpg';
    const contentType = 'image/jpeg';
  
    streamFile(req, res, filePath, contentType);
  });


//transformer
app.get('/transformer', (req, res) => {
    const filePath = './movies/transformer.mkv';
    const contentType = 'video/x-matroska';
  
    streamFile(req, res, filePath, contentType);
  });
  
  app.get('/transformer_img', (req, res) => {
    const filePath = './images/transformer_img.jpg';
    const contentType = 'image/jpeg';
  
    streamFile(req, res, filePath, contentType);
  });


// jailer
app.get('/jailer', (req, res) => {
    const filePath = './movies/jailer.mkv';
    const contentType = 'video/x-matroska';
  
    streamFile(req, res, filePath, contentType);
  });
  
  app.get('/jailer_img', (req, res) => {
    const filePath = './images/jailer_img.jpg';
    const contentType = 'image/jpeg';
  
    streamFile(req, res, filePath, contentType);
  });
const PORT = 5000;
app.listen(PORT, () => {
  console.log(`Server is connected to the port ${PORT}`);
});
