<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


    <div id="disp">
        <div class="row">
            <div class="col-2">
                <nav id="navbar-example2" class="navbar navbar-light bg-light flex-column">
                    <a class="navbar-brand">게시판 목록</a>
                    <nav class="nav nav-pills flex-column" id="test">
                    </nav>
                </nav>
            </div>
        </div>
    </div>
 <script>


/*
    let xhr = new XMLHttpRequest(); // 퀵서비시 호출
    xhr.open("get","/ourmine/boardType/boardTypeList",true);  // 할일 알려주고
    xhr.onreadystatechange = function(){  // 일이 종료 되었는지 모니터링
        if(xhr.readyState == 4 && xhr.status == 200){
            console.log(JSON.parse(xhr.responseText));
        }
    }
    xhr.send(); // 일을 시작하라
 */
  const jiDisp3 = document.querySelector("#test");

  const fboardList3 = function(resp){
    let tblStr = "<table border=1>";
        for(let i=0; i<resp.length; i++){
            tblStr += `<a href=/ourmine/board/boardList>`;
            tblStr += `\${resp[i].boardType}<br>`;
            tblStr += `</a>`;
        }
        tblStr += "</table>";
        jiDisp3.innerHTML = tblStr;
  }

  $.ajax({
    type:"get",
    url:"/ourmine/boardType/boardTypeList",
    async:true,
    dataType:"json",
    success:function(resp){
        console.log("결과확인",resp);  // 요기 코드가 길어지면  별도 함수로 처리/ 그래야 가독성이 유지됨
        fboardList3(resp);
    },
    error: function (request, status, error) {
        console.log("code: " + request.status)
        console.log("message: " + request.responseText)
        console.log("error: " + error);
    }

  })
  //             code += `

//             `
//             $('#jiModal').html(code);

                // 모달을 이용해서 상세/수정/삭제...
                /*
                let data = {
                    mdata : params.data.boardId
                };
                $.ajax({
                    url : '${cPath}/board/boardSelect',
                    data : JSON.stringify(data),   // data : {"bonum" : reply.bonum},
                    contentType:"application/json;charset=utf-8",
                    type : 'post',
                    dataType : 'json',  //   받아온 값에 JSON.parse
                    beforeSend : function(xhr){  // 헤더에 값 세팅, 항상 요따구로 씀
                        xhr.setRequestHeader(header, token);
                    },
                    success : function(res){
                        console.log("ckk: ",res);
                        //if(res.flag == "성공"){
                            //화면 수정
                       //            vhit = $(gthis).parents('.boardItem').find('.bh').text().trim();

                        //    vhit = parseInt(vhit) + 1;

                        //    $(gthis).parents('.boardItem').find('.bh').text(vhit);
                        //}
                    },
                    error : function(xhr){
                        alert("상태 : " + xhr.status);
                    }

               })
                */
</script>