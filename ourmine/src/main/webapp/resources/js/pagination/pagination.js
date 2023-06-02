/**
 * 
 */


const limit = 5;
let totlaCount = 21;
let totalPage = Math.ceil(totalCount / limit) // 5 올림함수
const currentPage = 7
const pageGroup = 1
const pageCount = 5
const totalPage = 11

let lastNumber = pageGroup * pageCount  // 5

if(lastNumber > totalPage){
	lastNumber = totalPage;
}
for (let i = firstNumber; i <= lastNumber; i++) {
  html += `<button class="pageNumber" id="page_${i}">${i}</button>`
}
const pageGroup = 3
const pageCount = 5
const totalPage = 11

let lastNumber = pageGroup * pageCount // 15
if (lastNumber > totalPage) {
  lastNumber = totalPage // 11
}

let firstNumber = lastNumber - (pageCount - 1) // 7

const next = lastNumber + 1 // 12
const prev = firstNumber - 1 // 6

fetch('/ourmine/board/boardList',{
	method : "get",
}).then(resp => resp.json())
.then(data => {
	console.log(data)
})
