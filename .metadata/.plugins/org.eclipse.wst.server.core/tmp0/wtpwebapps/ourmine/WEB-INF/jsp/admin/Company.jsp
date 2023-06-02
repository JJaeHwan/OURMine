<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     
<div class="row clearfix">
    <div class="col-md-12">
        <div class="card border-0 mb-4 no-bg">
            <div class="card-header py-3 px-0 d-flex align-items-center  justify-content-between border-bottom">
                <h3 class=" fw-bold flex-fill mb-0">회사목록</h3>
            </div>
        </div>
    </div>
</div><!-- Row End -->

<div id="companyList" class="row g-3 row-cols-1 row-cols-sm-1 row-cols-md-1 row-cols-lg-2 row-cols-xl-2 row-cols-xxl-2 row-deck py-1 pb-4">
 

</div>



<script>
const add = (a,b) => a + b;

let companyList = document.querySelector("#companyList");

fetch("/ourmine/company/companyList",{
      method : "GET",
      headers: {
         'accept': 'application/json',
      },
}).then(resp => resp.json())
   .then(data => {
      console.log("회사데이타",data);
      data.map(item=>{
          companyList.innerHTML+=
              `
           <div class="col">
		       <div class="card teacher-card">
		           <div class="card-body  d-flex">
		               <div class="profile-av pe-xl-4 pe-md-2 pe-sm-4 pe-4 text-center w220">
		                   <img src="assets/images/lg/avatar3.jpg" alt="" class="avatar xl rounded-circle img-thumbnail shadow-sm">
		                   <div class="about-info d-flex align-items-center mt-1 justify-content-center flex-column">
		                      <h6 class="mb-0 fw-bold d-block fs-6 mt-2">\${item.companyName}</h6>
		                   </div>
		               </div>
		               <div class="teacher-info border-start ps-xl-4 ps-md-3 ps-sm-4 ps-4 w-100">
		                   <h6  class="mb-0 mt-2  fw-bold d-block fs-6">\${item.companyCeo}</h6>
		                   <span class="py-1 fw-bold small-11 mb-0 mt-1 text-muted">매니저</span>
		                   <div class="video-setting-icon mt-3 pt-3 border-top">
		                       <p>주소: \${item.companyAddr}</p>
		                   </div>
		                   <div class="d-flex flex-wrap align-items-center ct-btn-set">
		                       <a href="chat.html" class="btn btn-dark btn-sm mt-1 me-1"><i class="icofont-ui-text-chat me-2 fs-6"></i>\${item.subscribeEndDate}</a>
		                       <a href="profile.html" class="btn btn-dark btn-sm mt-1"><i class="icofont-invisible me-2 fs-6"></i>D-\${item.subDay}</a>
		                   </div>
		               </div>
		           </div>
		       </div>
		   </div>
           `
      })

      
   })
	

</script>
