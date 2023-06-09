<%@page import="in.co.rays.proj4.util.DataUtility"%>
<%@page import="in.co.rays.proj4.bean.TimeTableBean"%>
<%@page import="in.co.rays.proj4.util.ServletUtility"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="in.co.rays.proj4.util.HTMLUtility"%>
<%@page import="in.co.rays.proj4.model.TimeTableModel"%>
<%@page import="in.co.rays.proj4.controller.TimeTableListCtl"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<link rel="icon" type="image/png"
	href="<%=ORSView.APP_CONTEXT%>/img/logo.png" sizes="16*16" />
<title>TimeTable List</title>

<script src="<%=ORSView.APP_CONTEXT%>/js/jquery.min.js"></script>
<script src="<%=ORSView.APP_CONTEXT%>/js/Checkbox11.js"></script>



<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">



<script>
	function disableSunday(d) {
		var day = d.getDay();
		if (day == 0) {
			return [ false ];
		} else {
			return [ true ];
		}
	}

	$(function() {
		$("#abcd").datepicker({
			changeMonth : true,
			changeYear : true,
			yearRange : '2002:2030',
			/* dateFormat : 'dd-mm-yy', */

			// Disable for Sunday
			beforeShowDay : disableSunday,
			// Disable for back date
			minDate : 0
		});
	});
</script>
 <script>
  $( function() {
    $( "#abcd" ).datepicker({
      changeMonth: true,
      changeYear: true,
	  yearRange:'2018:2030',
    dateFormat:'yy-mm-dd' 
    });
  } );
  </script>
</head>

<body>

	<jsp:useBean id="bean" class="in.co.rays.proj4.bean.TimeTableBean"
		scope="request"></jsp:useBean>
	<%@include file="Header.jsp"%>


	<form action="<%=ORSView.TIMETABLE_LIST_CTL%>" method="post">

		<center>

			<div align="center">
				<h1>TimeTable List</h1>

				<h3>

					<font style="font: bold; color: red"><%=ServletUtility.getErrorMessage(request)%></font>
					<font style="font: bold; color: green"><%=ServletUtility.getSuccessMessage(request)%></font>
				</h3>
			</div>

			<%
				List cList = (List) request.getAttribute("courseList");

				List sList = (List) request.getAttribute("subjectList");

				int next = DataUtility.getInt(request.getAttribute("nextlist").toString());
			%>
			<%
				int pageNo = ServletUtility.getPageNo(request);
				int pageSize = ServletUtility.getPageSize(request);
				int index = ((pageNo - 1) * pageSize) + 1;

				List list = ServletUtility.getList(request);
				Iterator<TimeTableBean> it = list.iterator();

				if (list.size() != 0) {
			%>

			<table width="100%">
				<tr>
					<td align="center"><label>Course Name :</label> <%=HTMLUtility.getList("clist", String.valueOf(bean.getCourseId()), cList)%>

						<label>Subject Name :</label> <%=HTMLUtility.getList("slist", String.valueOf(bean.getSubjectId()), sList)%>
						
						
                  <%-- <label>ExamTime</label>
                    <input type="text" name="ExameTime" placeholder="Select Exam Time" value="<%=DataUtility.getStringData(bean.getExamTime())%>">
                    --%>
            
<%-- 
						<label>Date Of Exam :</label> <input type="text" name="ExDate" id="abcd"
						  placeholder="Select Date"
						value="<%=ServletUtility.getParameter("ExDate", request)%>">
						 --%>
						&nbsp; <input type="submit" name="operation"
						value="<%=TimeTableListCtl.OP_SEARCH%>"> &nbsp; <input
						type="submit" name="operation"
						value="<%=TimeTableListCtl.OP_RESET%>"></td>
				</tr>
			</table>
			<br>
			<table border="1" width="100%" align="center" cellpadding=6px
				cellspacing="2">
				<tr style="background: #E5E4E2">

					<th width="8%"><input type="checkbox" id="select_all"
						name="Select">Select All.</th>
					<th>S.No.</th>
					<th>Course Name.</th>
					<th>Subject Name.</th>
					<th>Semester.</th>
					<th>ExamDate.</th>
					<th>ExamTime.</th>
					<th>Edit</th>

				</tr>
				<%
					while (it.hasNext()) {
							bean = it.next();
				%>
				<tr align="center">
					<td><input type="checkbox" class="checkbox" name="ids"
						value="<%=bean.getId()%>"></td>
					<td><%=index++%></td>
					<td><%=bean.getCourseName()%></td>
					<td><%=bean.getSubjectName()%></td>
					<td><%=bean.getSemester()%></td>
					<td><%=bean.getExamDate()%></td>
					<td><%=bean.getExamTime()%></td>
					<td><a href="TimeTableCtl?id=<%=bean.getId()%>">Edit</a></td>
				</tr>
				<%
					}
				%>
			</table>

			<table width="100%">
				<tr>
					<th></th>
					<%
						if (pageNo == 1) {
					%>
					<td align="left"><input type="submit" name="operation"
						disabled="disabled" value="<%=TimeTableListCtl.OP_PREVIOUS%>"></td>
					<%
						} else {
					%>
					<td align="left"><input type="submit" name="operation"
						value="<%=TimeTableListCtl.OP_PREVIOUS%>"></td>
					<%
						}
					%>

					<td><input type="submit" name="operation"
						value="<%=TimeTableListCtl.OP_DELETE%>"></td>
					<td><input type="submit" name="operation"
						value="<%=TimeTableListCtl.OP_NEW%>"></td>

					<%
						TimeTableModel model = new TimeTableModel();
					%>

					<%--  <%if(list.size()<pageSize ||model.nextPk()-1 == bean.getId()){ 
		 
				
		 %>	
		 
			<td align="right"><input type="submit" disabled="disabled" name="operation" value="<%=TimeTableListCtl.OP_NEXT%>" ></td>
			<%}else{ %>
			<td align="right"><input typeRR="submit" name="operation" value="<%=TimeTableListCtl.OP_NEXT%>" ></td>
			<%} %> --%>

					<td align="right"><input type="submit" name="operation"
						value="<%=TimeTableListCtl.OP_NEXT%>"
						<%=(list.size() < pageSize || next == 0) ? "disabled" : ""%>></td>

				</tr>
			</table>

			<%
				}
				if (list.size() == 0) {
			%>
			<td align="center"><input type="submit" name="operation"
				value="<%=TimeTableListCtl.OP_BACK%>"></td>
			<%
				}
			%>


			<input type="hidden" name="pageNo" value="<%=pageNo%>"> <input
				type="hidden" name="pageSize" value="<%=pageSize%>">
	</form>
	</br>
	</br>
	</center>

	<%@include file="Footer.jsp"%>
</body>
</html>