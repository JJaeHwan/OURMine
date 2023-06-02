<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<%-- <script src="${cPath}/resources/js/apexcharts.min.js"></script> --%>

<style>

</style>


<div id="mytask-layout" >
    <!-- main body area -->
    <div class="main px-lg-4 px-md-4">
        <!-- Body: Body -->
        <div class="body d-flex py-3">
         <!-- Row End -->

                        <div class="card">
                            <div  class="card-header py-3 d-flex justify-content-between align-items-center">
                                <div class="info-header">
                                    <h6 class="mb-0 fw-bold ">Project Timeline</h6>
                                </div>
                                <button class="btn btn-sm btn-link  dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false"></button>
                                <ul class="dropdown-menu border-0 shadow dropdown-menu-end">
                                    <li><a class="dropdown-item py-2 rounded" href="#">Last 7 days</a></li>
                                    <li><a class="dropdown-item py-2 rounded" href="#">Last 30 days</a></li>
                                    <li><a class="dropdown-item py-2 rounded" href="#">Last 60 days</a></li>
                                </ul>
                            </div>
                            <div class="card-body">
                                <div id="apex-timeline"></div>

                            </div>
                        </div>
                <!-- Row End -->
        </div>
    </div>
</div>

<script>
// Timeline
$(document).ready(function(data) {

   console.log("간트차트");
    $.ajax({
         url: "/ourmine/company/${companyId}/project/${projectId}/projectGantt/ganttList", // 데이터를 가져올 JSP 페이지의 URL
         method: "GET",
         contentType: "application/json;charset=utf-8",
         dataType: "json",
         success: function(data) {
             // 데이터를 가져온 후 차트를 생성하는 로직
             // 차트에 사용할 데이터 배열
             var seriesData = [];
             var names = [];


             /* var date= {
            		 yaxis: [new Date(date.projectStart), new Date(date.projectEnd)]
             }
             console.log(date);*/

             // 데이터 배열에 name:담당자, x:일감 및 y:날짜 정보를 추가

             /*
               억지 데이터 모양 맹글기
               나중에 리팩토링(함수로) 하면 좋을 듯
             */
             for (var i = 0; i < data.length; i++) {
                 var item = data[i];
                 //names.push(item.name);
                 var chartItem = {
                     x: item.x,
                     y:[new Date(item.start), new Date(item.end)],
                 };


                 var isRepeat = false;
                 var sIndex;
                 for(let j=0; j < seriesData.length; j++){
                        for(let z=0; z<seriesData[j].data.length; z++){
                           //console.log("비교",seriesData[j].name, item.name)
                            if(seriesData[j].name == item.name){
                              isRepeat = true;
                              sIndex =j;
                              break;
                           }
                        }
                 }

                 if(isRepeat){
                    seriesData[sIndex].data.push(chartItem);
                 }else {
                     var chartData = {
                             name: item.name,
                             data: [chartItem]
                     };
                     seriesData.push(chartData);
                 }

             }

             // 최소 날짜와 최대 날짜를 찾아서 y축의 범위를 설정하는 부분
             var mindates = data.map(function(item) {
                 return new Date(item.min);
             });


             var maxdates = data.map(function(item) {
                 return new Date(item.max);
             });


             var minDate = new Date(Math.min.apply(null, mindates));
             var maxDate = new Date(Math.max.apply(null, maxdates));

             console.log("minDate",minDate);



             console.log("@@@나재경@@@:",seriesData);

             var options = {
                     chart: {
                         height: 600,
                         type: 'rangeBar',
                         toolbar: {
                             show: false,
                         },
                         theme: {
                               mode: 'dark' // 테마 모드 설정 (light, dark, or custom)
                             }
                     },
                     plotOptions: {
                         bar: {
                             barHeight: '99%',
                             horizontal: true,
                         }
                     },

                     colors: ['var(--chart-color1)', 'var(--chart-color2)', 'var(--chart-color3)','var(--chart-color4)'
                             , 'var(--chart-color5)', 'var(--chart-color6)','var(--chart-color7)','var(--chart-color8)'],


                     series: seriesData,
                     noData: {
                         text: 'Loading...'
                       },
                     yaxis: {
                    	type: 'datetime',
                    	min: minDate.getTime(),
                    	max: maxDate.getTime()
                     },
                     xaxis: {
                        type: 'datetime',
                     }
                 };

             var chart = new ApexCharts(
                     document.querySelector("#apex-timeline"),
                     options
                 );

                 chart.render();

/*           // ApaxChart RangeBar 생성
            var chart = new ApaxChart({
                        container: document.querySelector("#apex-timeline"),
                        series: [{
                            type: 'rangebar',
                            data: chartData
                        }]
                    });

             // 차트 그리기
             chart.draw(); */
         },
         error: function(xhr, status, error) {
             // 오류 처리
             console.log(error);
        }
    });
});




        /* var options = {
            chart: {
                height: 600,
                type: 'rangeBar',
                toolbar: {
                    show: false,
                },
                theme: 'light' // 테마지정?
            },
            plotOptions: {
                bar: {
                    horizontal: true,
                }
            },

            colors: ['var(--chart-color1)', 'var(--chart-color2)', 'var(--chart-color4)'],

            series: [{
               data: chartData
            }],
            noData: {
                text: 'Loading...'
              },
            yaxis: {
                min: new Date('2023-05-01').getTime(),
                max: new Date('2023-05-30').getTime(),
                //max: new Date('2020-03-18').getTime(),
            },
            xaxis: {
               type: 'datetime'
            }
        };

    var chart = new ApexCharts(
            document.querySelector("#apex-timeline"),
            options
        );

        chart.render(); */



    /* function projectGanttList(){

      axios({
        method: 'GET',
        url: "/ourmine/company/{companyId}/project/{projectId}/projectGantt/ganttList",
      }).then(function(response) {
        chart.updateSeries([{
          name: ganttList(data),
          data: response.data
        }])
      })

    } */


</script>

<script src="${cPath}/resources/js/apexcharts.bundle.js"></script>
<%-- <script src="${cPath}/resources/js/dataTables.bundle.js"></script> --%>
<%-- <script src="${cPath}/resources/js/index.js"></script> --%>
