
/*
function asyncFunction(callback) {
  setTimeout(() => {
    console.log('Bắt đầu thực thi hàm bất đồng bộ');
    // Thực hiện các tác vụ bất đồng bộ (ví dụ: đọc tệp, kết nối mạng)
    const result = 'Kết quả xử lý bất đồng bộ';
    callback(result);
    console.log('Kết thúc thực thi hàm bất đồng bộ');
  }, 1000);
}

asyncFunction((result) => {
  console.log('Nhận được kết quả:', result);
});

console.log('Tiếp tục thực thi chương trình');
*/ 

/*

const fs = require('fs');

fs.readFile('data.txt', (err, data) => {
  if (err) {
    console.error(err);
    return;
  }
  console.log(data.toString());
});

console.log('Tiếp tục thực thi chương trình');
*/

const fs = require('fs');

async function readFile(fileName) {
  const data = fs.promises.readFile(fileName);
  return data.toString();
}

(async () => {
  const data = await readFile('data.txt');
  console.log(data);
})();


console.log("check sync");
