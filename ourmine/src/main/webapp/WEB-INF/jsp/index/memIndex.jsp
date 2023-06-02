<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<script type="text/javascript" src="${cPath}/resources/js/jquery-3.6.3.min.js"></script>

<style>
	.card::-webkit-scrollbar {
	  display: none; /* Chrome, Safari, and Opera */
	}
</style>

<div id="mytask-layout" class="theme-indigo">
    
    <!-- main body area -->
    <div class="main px-lg-4 px-md-4">

        <!-- Body: Body -->
        <div class="body d-flex py-3">
            <div class="container-xxl">
                <div class="row clearfix g-3">
                    <div class="col-xl-8 col-lg-12 col-md-12 flex-column">
                        <div class="row g-3">
                            <div class="col-md-12">
                                <div class="card">
                                    <div class="card-header py-3 d-flex justify-content-between bg-transparent border-bottom-0">
                                        <h6 class="mb-0 fw-bold ">프로젝트 월별 진행률</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="ac-line-transparent" id="apex-emplyoeeAnalytics"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="card">
                                    <div class="card-header py-3 d-flex justify-content-between bg-transparent border-bottom-0">
                                        <h6 class="mb-0 fw-bold ">산출물</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="row g-2 row-deck">
                                            <div class="col-md-6 col-sm-6">
                                                <div class="card">
                                                    <div class="card-body ">
                                                        <i class="icofont-home fs-3"></i>
                                                        <h6 class="mt-3 mb-0 fw-bold small-14">프로젝트</h6>
                                                        <span class="text-muted">400</span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6 col-sm-6">
                                                <div class="card">
                                                    <div class="card-body ">
                                                            <i class="icofont-files-stack fs-3"></i>
                                                        <h6 class="mt-3 mb-0 fw-bold small-14">일감</h6>
                                                        <span class="text-muted">17</span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6 col-sm-6">
                                                <div class="card">
                                                    <div class="card-body ">
                                                            <i class="icofont-ui-clip-board fs-3"></i>
                                                        <h6 class="mt-3 mb-0 fw-bold small-14">이슈</h6>
                                                        <span class="text-muted">06</span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6 col-sm-6">
                                                <div class="card">
                                                    <div class="card-body ">
                                                        <i class="icofont-ui-folder fs-3"></i>
                                                        <h6 class="mt-3 mb-0 fw-bold small-14">파일</h6>
                                                        <span class="text-muted">14</span> 
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="card">
                                    <div class="card-header py-3 d-flex justify-content-between bg-transparent border-bottom-0">
                                        <h6 class="mb-0 fw-bold ">프로젝트 완성 비율</h6>
                                        <h4 class="mb-0 fw-bold ">423</h4>
                                    </div>
                                    <div class="card-body">
                                        <div class="mt-3" id="apex-MainCategories"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="card">
                                    <div class="card-header py-3 d-flex justify-content-between bg-transparent border-bottom-0">
                                        <h6 class="mb-0 fw-bold ">부서별 월간 진행률</h6>
                                    </div>
                                    <div class="card-body">
                                        <div id="hiringsources"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-4 col-lg-12 col-md-12">
                        <div class="row g-3 row-deck">
                            <div class="col-md-6 col-lg-6 col-xl-12">
                                <div class="card bg-primary">
                                    <div class="card-body row">
                                        <div class="col">
                                            <span class="avatar lg bg-white rounded-circle text-center d-flex align-items-center justify-content-center"><i class="icofont-institution fs-5"></i></span>
                                            <h1 class="mt-3 mb-0 fw-bold text-white">OURmine</h1>
                                        </div>
                                        <div class="col">
                                            <img class="img-fluid" src="${cPath}/resources/images/interview.svg" alt="interview">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-6 col-xl-12  flex-column">
                                <div class="card mb-3">
                                    <div class="card-body">
                                        <div class="d-flex align-items-center flex-fill">
                                            <span class="avatar lg light-success-bg rounded-circle text-center d-flex align-items-center justify-content-center"><i class="icofont-users-alt-2 fs-5"></i></span>
                                            <div class="d-flex flex-column ps-3  flex-fill">
                                                <span class="text-muted">직원</span>
                                                <h6 class="fw-bold mb-0 fs-4">246</h6>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="card">
                                    <div class="card-body">
                                        <div class="d-flex align-items-center flex-fill">
                                            <span class="avatar lg light-success-bg rounded-circle text-center d-flex align-items-center justify-content-center"><i class="icofont-handshake-deal fs-5"></i></span>
                                            <div class="d-flex flex-column ps-3 flex-fill">
                                                <span class="text-muted">프리랜서</span>
                                                <h6 class="fw-bold mb-0 fs-4">101</h6>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12 col-lg-12 col-xl-12">
                                <div class="card" style="height: 610px; overflow-y: scroll;">
	                                <div class="card-body">
	                                    <div class="flex-grow-1">
	                                        <div class="py-2 d-flex align-items-center border-bottom flex-wrap">
	                                            <div class="d-flex align-items-center flex-fill">
	                                                <img class="avatar lg rounded-circle img-thumbnail" src="${cPath}/resources/images/xs/마스코트_투명.png" alt="profile">
	                                                <div class="d-flex flex-column ps-3">
	                                                    <h6 class="fw-bold mb-0 small-14">정재환</h6>
	                                                    <span class="text-muted">wjdwoghks@naver.com</span>
	                                                </div>
	                                            </div>
	                                            <div class="time-block text-truncate">
	                                                <i class="icofont-id-card"></i> MANAGER
	                                            </div>
	                                        </div>
	                                        <div class="py-2 d-flex align-items-center border-bottom flex-wrap">
	                                            <div class="d-flex align-items-center flex-fill">
	                                                <img class="avatar lg rounded-circle img-thumbnail" src="${cPath}/resources/images/xs/마스코트_투명.png" alt="profile">
	                                                <div class="d-flex flex-column ps-3">
	                                                    <h6 class="fw-bold mb-0 small-14">강지웅</h6>
	                                                    <span class="text-muted">rkdwldnd@naver.com</span>
	                                                </div>
	                                            </div>
	                                            <div class="time-block text-truncate">
	                                                <i class="icofont-id-card"></i> MANAGER
	                                            </div>
	                                        </div>
	                                        <div class="py-2 d-flex align-items-center border-bottom flex-wrap">
	                                            <div class="d-flex align-items-center flex-fill">
	                                                <img class="avatar lg rounded-circle img-thumbnail" src="${cPath}/resources/images/xs/마스코트_투명.png" alt="profile">
	                                                <div class="d-flex flex-column ps-3">
	                                                    <h6 class="fw-bold mb-0 small-14">배성환</h6>
	                                                    <span class="text-muted">qotjdghks@naver.com</span>
	                                                </div>
	                                            </div>
	                                            <div class="time-block text-truncate">
	                                                <i class="icofont-id-card"></i> MANAGER
	                                            </div>
	                                        </div>
	                                        <div class="py-2 d-flex align-items-center border-bottom flex-wrap">
	                                            <div class="d-flex align-items-center flex-fill">
	                                                <img class="avatar lg rounded-circle img-thumbnail" src="${cPath}/resources/images/xs/마스코트_투명.png" alt="profile">
	                                                <div class="d-flex flex-column ps-3">
	                                                    <h6 class="fw-bold mb-0 small-14">김지현</h6>
	                                                    <span class="text-muted">rlawlgus@naver.com</span>
	                                                </div>
	                                            </div>
	                                            <div class="time-block text-truncate">
	                                                <i class="icofont-id-card"></i> MEMBER
	                                            </div>
	                                        </div>
	                                        <div class="py-2 d-flex align-items-center border-bottom flex-wrap">
	                                            <div class="d-flex align-items-center flex-fill">
	                                                <img class="avatar lg rounded-circle img-thumbnail" src="${cPath}/resources/images/xs/마스코트_투명.png" alt="profile">
	                                                <div class="d-flex flex-column ps-3">
	                                                    <h6 class="fw-bold mb-0 small-14">나재경</h6>
	                                                    <span class="text-muted">skworud@naver.com</span>
	                                                </div>
	                                            </div>
	                                            <div class="time-block text-truncate">
	                                                <i class="icofont-id-card"></i> MEMBER
	                                            </div>
	                                        </div>
	                                        <div class="py-2 d-flex align-items-center border-bottom flex-wrap">
	                                            <div class="d-flex align-items-center flex-fill">
	                                                <img class="avatar lg rounded-circle img-thumbnail" src="${cPath}/resources/images/xs/마스코트_투명.png" alt="profile">
	                                                <div class="d-flex flex-column ps-3">
	                                                    <h6 class="fw-bold mb-0 small-14">이제인</h6>
	                                                    <span class="text-muted">dlwpdls@naver.com</span>
	                                                </div>
	                                            </div>
	                                            <div class="time-block text-truncate">
	                                                <i class="icofont-id-card"></i> MEMBER
	                                            </div>
	                                        </div>
	                                        <div class="py-2 d-flex align-items-center border-bottom flex-wrap">
	                                            <div class="d-flex align-items-center flex-fill">
	                                                <img class="avatar lg rounded-circle img-thumbnail" src="${cPath}/resources/images/xs/마스코트_투명.png" alt="profile">
	                                                <div class="d-flex flex-column ps-3">
	                                                    <h6 class="fw-bold mb-0 small-14">박성룡</h6>
	                                                    <span class="text-muted">qkrtjdfyd@naver.com</span>
	                                                </div>
	                                            </div>
	                                            <div class="time-block text-truncate">
	                                                <i class="icofont-id-card"></i> MEMBER
	                                            </div>
	                                        </div>
	                                        <div class="py-2 d-flex align-items-center border-bottom flex-wrap">
	                                            <div class="d-flex align-items-center flex-fill">
	                                                <img class="avatar lg rounded-circle img-thumbnail" src="${cPath}/resources/images/xs/마스코트_투명.png" alt="profile">
	                                                <div class="d-flex flex-column ps-3">
	                                                    <h6 class="fw-bold mb-0 small-14">박성룡</h6>
	                                                    <span class="text-muted">qkrtjdfyd@naver.com</span>
	                                                </div>
	                                            </div>
	                                            <div class="time-block text-truncate">
	                                                <i class="icofont-id-card"></i> MEMBER
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="card light-danger-bg">
                            <div class="card-header py-3 d-flex justify-content-between bg-transparent border-bottom-0">
                                <h6 class="mb-0 fw-bold ">팀별 프로젝트 진행도</h6>
                            </div>
                            <div class="card-body">
                                <div class="row g-3 align-items-center">
                                    <div class="col-md-12 col-lg-12 col-xl-12 col-xxl-12">
                                        <div class="row g-3 row-cols-2 row-cols-sm-3 row-cols-md-3 row-cols-lg-3 row-cols-xl-3 row-cols-xxl-6 row-deck top-perfomer">
                                            <div class="col">
                                                <div class="card shadow">
                                                    <div class="card-body text-center d-flex flex-column justify-content-center">
                                                        <img class="avatar lg rounded-circle img-thumbnail mx-auto" src="${cPath}/resources/images/xs/마스코트_투명.png" alt="profile">
                                                        <h6 class="fw-bold my-2 small-14">PM 이름</h6>
                                                        <span class="text-muted mb-2">@프로젝트명</span>
                                                        <h4 class="fw-bold text-primary fs-3">80%</h4>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col">
                                                <div class="card shadow">
                                                    <div class="card-body text-center d-flex flex-column justify-content-center">
                                                        <img class="avatar lg rounded-circle img-thumbnail mx-auto" src="${cPath}/resources/images/xs/마스코트_투명.png" alt="profile">
                                                        <h6 class="fw-bold my-2 small-14">PM 이름</h6>
                                                        <span class="text-muted mb-2">@프로젝트명</span>
                                                        <h4 class="fw-bold text-primary fs-3">70%</h4>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col">
                                                <div class="card shadow">
                                                    <div class="card-body text-center d-flex flex-column justify-content-center">
                                                        <img class="avatar lg rounded-circle img-thumbnail mx-auto" src="${cPath}/resources/images/xs/마스코트_투명.png" alt="profile">
                                                        <h6 class="fw-bold my-2 small-14">PM 이름</h6>
                                                        <span class="text-muted mb-2">@프로젝트명</span>
                                                        <h4 class="fw-bold text-primary fs-3">77%</h4>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col">
                                                <div class="card shadow">
                                                    <div class="card-body text-center d-flex flex-column justify-content-center">
                                                        <img class="avatar lg rounded-circle img-thumbnail mx-auto" src="${cPath}/resources/images/xs/마스코트_투명.png" alt="profile">
                                                        <h6 class="fw-bold my-2 small-14">PM 이름</h6>
                                                        <span class="text-muted mb-2">@프로젝트명</span>
                                                        <h4 class="fw-bold text-primary fs-3">85%</h4>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col">
                                                <div class="card shadow">
                                                    <div class="card-body text-center d-flex flex-column justify-content-center">
                                                        <img class="avatar lg rounded-circle img-thumbnail mx-auto" src="${cPath}/resources/images/xs/마스코트_투명.png" alt="profile">
                                                        <h6 class="fw-bold my-2 small-14">PM 이름</h6>
                                                        <span class="text-muted mb-2">@프로젝트명</span>
                                                        <h4 class="fw-bold text-primary fs-3">95%</h4>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col">
                                                <div class="card shadow">
                                                    <div class="card-body text-center d-flex flex-column justify-content-center">
                                                        <img class="avatar lg rounded-circle img-thumbnail mx-auto" src="${cPath}/resources/images/xs/마스코트_투명.png" alt="profile">
                                                        <h6 class="fw-bold my-2 small-14">PM 이름</h6>
                                                        <span class="text-muted mb-2">@프로젝트명</span>
                                                        <h4 class="fw-bold text-primary fs-3">97%</h4>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div><!-- Row End -->
            </div>
        </div> 

    </div>

</div>

<script>
if (typeof jQuery === "undefined") {
    throw new Error("jQuery plugins need to be before this file");
}
$(function() {
    "use strict";
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl)
    })

    // 프로젝트 완성 비율
    $(document).ready(function() {
        var options = {
            align: 'center',
            chart: {
                height: 250,
                type: 'donut',
                align: 'center',
            },
            labels: ['진행', '완료'],
            dataLabels: {
                enabled: false,
            },
            legend: {
                position: 'bottom',
                horizontalAlign: 'center',
                show: true,
            },
            colors: ['var(--chart-color4)', 'var(--chart-color3)'],
            series: [42, 58],
            responsive: [{
                breakpoint: 480,
                options: {
                    chart: {
                        width: 200
                    },
                    legend: {
                        position: 'bottom'
                    }
                }
            }]
        }
        var chart = new ApexCharts( document.querySelector("#apex-MainCategories"),options);        
        chart.render();
    }); 

    // 프로젝트 월별 진행률
    $(document).ready(function() { 
        var options = {
            series: [{
                name: 'Available',
                data: [4, 19, 7, 35, 14, 27, 9, 12],
            }],
                chart: {
                height: 140,
                type: 'line',
                toolbar: {
                    show: false,
                }
            },
            grid: {
                show: false,
                xaxis: {
                    lines: {
                        show: false
                    }
                },   
                yaxis: { 
                    lines: {
                        show: false
                    }
                }, 
            },
            stroke: {
                width: 4,
                curve: 'smooth',
                colors: ['var(--chart-color2)'],
            },
            xaxis: {
                type: 'datetime',
                categories: ['1/11/2021', '2/11/2021', '3/11/2021', '4/11/2021', '5/11/2021', '6/11/2021', '7/11/2021', '8/11/2021'],
                tickAmount: 10,
                labels: {
                    formatter: function(value, timestamp, opts) {
                        return opts.dateFormatter(new Date(timestamp), 'dd MMM')
                    }
                }
            },
            fill: {
                type: 'gradient',
                gradient: {
                    shade: 'dark',
                    gradientToColors: [ "var(--chart-color3)" ],
                    shadeIntensity: 1,
                    type: 'horizontal',
                    opacityFrom: 1,
                    opacityTo: 1,
                    stops: [0, 100, 100, 100],
                },
            },
            markers: {
                size: 3,
                colors: ["#FFA41B"],
                strokeColors: "#ffffff",
                strokeWidth: 2,
                hover: {
                    size: 7,
                }
            },
            yaxis: {
                show: false,
                min: -10,
                max: 50,
            }
        };

        var chart = new ApexCharts(document.querySelector("#apex-emplyoeeAnalytics"), options);
        chart.render();
    });  

     // 부서별 월간 진행률
    $(document).ready(function() {
        
        var options = {
            series: [{
                name: '부서명',
                data: [45, 25, 44, 23, 25, 41, 32, 25, 22, 65, 22, 29]
            }, {
                name: '부서명',
                data: [45, 12, 25, 22, 19, 22, 29, 23, 23, 25, 41, 32]
            }, {
                name: '부서명',
                data: [45, 25, 32, 25, 22, 65, 44, 23, 25, 41, 22, 29]
            }, {
                name: '부서명',
                data: [32, 25, 22, 11, 22, 29, 16, 25, 9, 23, 25, 13]
            }],
            chart: {
                type: 'bar',
                height: 300,
                stacked: true,
                toolbar: {
                    show: false
                },
                zoom: {
                    enabled: true
                }
            },
            colors: ['var(--chart-color1)','var(--chart-color2)','var(--chart-color3)','var(--chart-color4)'],
            responsive: [{
                breakpoint: 480,
                options: {
                    legend: {
                        position: 'bottom',
                        offsetX: -10,
                        offsetY: 0
                    }
                }
            }],
            xaxis: {
                categories: ['Jan','Feb','March','Apr','May','Jun','July','Aug','Sept','Oct','Nov','Dec'],
            },
            legend: {
                position: 'top', // top, bottom
                horizontalAlign: 'right', // left, right
            },
            dataLabels: {
                enabled: false,
            },
            fill: {
                opacity: 1
            }
        };

        var chart = new ApexCharts(document.querySelector("#hiringsources"), options);
        chart.render();
    });
});

</script>