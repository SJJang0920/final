<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<div class="row">
			<h1 class="pagetitle">충전소 정보 조회</h1>
			<div class="card-body stationWrap col-lg-12">
				<form action="/evweb/admin/station/read.do?stationId=${read.station_id}&state=UPDATE" method="post">
					<div class="row mb-3">
						<label for="station_name" class="col-sm-2 col-form-label">충전소 ID</label>
						<div class="col-sm-10">
						  <input type="text" class="form-control" name="station_name" id="station_name" value="${read.station_id}" readonly="readonly">
						</div>
					</div>
					<div class="row mb-3">
						<label for="station_name" class="col-sm-2 col-form-label">충전소 이름</label>
						<div class="col-sm-10">
						  <input type="text" class="form-control" name="station_name" id="station_name" value="${read.station_name}" readonly="readonly">
						</div>
					</div>
					<div class="row mb-3">
						<label for="station_company" class="col-sm-2 col-form-label">충전소 회사</label>
						<div class="col-sm-10">
						  <input type="text" class="form-control" name="station_company" id="station_company" value="${read.station_company}" readonly="readonly">
						</div>
					</div>
					<div class="row mb-3">
						<label for="charger_no" class="col-sm-2 col-form-label">충전기 대수</label>
						<div class="col-sm-2">
						  <input type="text" class="form-control" name="charger_no" id="charger_no" value="${read.charger_no}" readonly="readonly">
						</div>
						<div class="mb-2">
						  <button type="button" id="chrgrInfo" class="btn btn-primary"><i class="bi bi-search"></i>충전기 정보</button>
						</div>
					</div>
					<div class="row mb-3"> 
						<label for="addr_do" class="col-sm-2 col-form-label">주소</label>
						<div class="col-sm-10">
						  <input type="text" class="form-control" name="addr_do" id="addr_do" value="${read.addr_do} ${read.addr_sigun} ${read.addr_detail}" readonly="readonly">
						</div>
					</div>
					<div class="row mb-3">
						<label for="manager_id" class="col-sm-2 col-form-label">담당자</label>
						<div class="col-sm-10">
						  <input type="text" class="form-control" name="manager_id" id="manager_id" value="${read.manager_id}" readonly="readonly">
						</div>
					</div>
					<div class="row mb-3">
						<label for="service_date" class="col-sm-2 col-form-label">서비스기간</label>
						<div class="col-sm-10">
						  <input type="text" class="form-control" name="service_date" id="service_date" value="${read.service_date}" readonly="readonly">
						</div>
					</div>
					<div class="text-center">
						<button type="button" class="btn btn-secondary" onclick="history.go(-2)" ><i class="bi bi-list-ul"></i>목록</button>
						<button type="submit" class="btn btn-primary"><i class="bi bi-pencil-square"></i>수정</button>
						<button type="button" class="btn btn-secondary delBtn"><i class="bi bi-trash"></i>삭제</button>
					</div>
				</form>
			</div>
			<div class="alertPop">
				<div class="alertBox">
					<div class="modal fade">
						<div class="modal-dialog modal-dialog-centered">
							<div class="modal-content insert chrgrlist">
								<div class="modal-header">
									<h5 class="modal-title pagetitle"><i class="bi bi-ev-station"></i>충전기 정보</h5>
								</div>
								<div class="modal-body">
					              <table class="table table-hover">
					                <thead class="fixedHeader">
					                  <tr>
					                    <th scope="col" class="tb-center">충전기 ID</th>
					                    <th scope="col" class="tb-center">타입</th>
					                    <th scope="col" class="tb-center">충전방식</th>
					                    <th scope="col" class="tb-center">용량(kW)</th>
					                    <th scope="col" class="tb-center">현재상태</th>
					                    <th scope="col" class="tb-center">업데이트일자</th>
					                    <th scope="col" class="tb-center">삭제</th>
					                  </tr>
					                </thead>
					                <tbody id="list">
					                </tbody>
					              </table>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary cancel"><i class="bi bi-dash-square"></i>닫기</button>
								</div>
							</div>
							<div class="modal-content delete">
								<div class="modal-header">
									<h5 class="modal-title">삭제하시겠습니까?</h5>
								</div>
								<div class="modal-body">
									데이터를 삭제하면 복구는 불가능합니다. 그래도 삭제하시겠습니까?
								</div>
								<div class="modal-footer">
									<button type="button" id="delBtn" class="btn btn-primary"><i class="bi bi-check-square"></i>예</button>
									<button type="button" class="btn btn-secondary cancel"><i class="bi bi-dash-square"></i>아니오</button>
								</div>
							</div>
						</div>
					</div>
				</div>
          </div>
         </div>
	</body>
	<script type="text/javascript">
		$(document).ready(function () {
			// 삭제 전 확인 alert
			$(".delBtn").click(function () {
				$(".alertPop .modal").addClass("show");
				$(".alertPop .modal-content.delete").addClass("show");
			});
			$(".cancel").click(function () {
				$(".alertPop .modal").removeClass("show");
				$(".alertPop .modal-content").removeClass("show");
			});

			$("#delBtn").click(function () {
				$(".alertPop .modal").removeClass("show");
				location.href='/evweb/admin/station/delete.do?stationId=${read.station_id}';
			});
			var stationId = "${read.station_id}";
			$("#chrgrInfo").click(function () {
				$(".alertPop .modal").addClass("show");
				$(".alertPop .modal-content.chrgrlist").addClass("show");
				
				$.ajax({
					url: "/evweb/ajax/chargerInfo",
					type: "get",
					data: {
						"stationId" : stationId
					},
					success:function(data){
						strHTML = "";
						for (var i = 0; i < data.length; i++) {
							strHTML += "<tr>";
							strHTML += "<td class='chrgrId tb-center'>"+ data[i].charger_id + "</td>";
							strHTML += "<td class='chrgrType tb-center'>"+ data[i].charger_type + "</td>";
							strHTML += "<td class='chrgrMethod tb-center'>"+ data[i].method + "</td>";
							strHTML += "<td class='chrgrOut tb-center'>"+ data[i].output + "</td>";
							strHTML += "<td class='chrgrStat tb-center'>"+ data[i].stat + "</td>";
							strHTML += "<td class='chrgrUdt tb-center'>"+ data[i].stat_UpdDt + "</td>";
							strHTML += "<td class='chrgrDelYn tb-center'>"+ data[i].delYn + "</td>";
							strHTML += "</tr>";
						}
						$("#list").html(strHTML);
						
					},
					error: function error_run(obj, msg, statusMsg) {
						alert("오류발생 ->"+obj+","+msg+","+statusMsg);
					}
				});

			});
		});
	</script>
</html>