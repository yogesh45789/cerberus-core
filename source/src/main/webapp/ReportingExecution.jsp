<%-- 
    Document   : ReportingExecution
    Created on : 10 mars 2011, 10:09:26
    Author     : acraske
--%>


<%@page import="com.redcats.tst.service.IApplicationService"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Set"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<% Date DatePageStart = new Date();%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Execution Reporting : Status</title>
        <link rel="stylesheet" type="text/css" href="css/crb_style.css">
        <link rel="shortcut icon" type="image/x-icon" href="images/favicon.ico" />
    </head>
    <body>
        <%@ include file="include/function.jsp" %>
        <%@ include file="include/header.jsp" %>
        <div id="body">
            <%
                String tcclauses = " WHERE 1=1 ";
                String execclauses = " 1=1 ";
                String URL = "Apply=Apply";
                String insertURL = "";
                String enable = "disabled";


                String tag;
                if (request.getParameter("Tag") != null && request.getParameter("Tag").compareTo("") != 0) {
                    tag = request.getParameter("Tag");
                    URL = URL + "&Tag=" + tag;
                    execclauses = execclauses + " AND Tag = '" + tag + "'";
                } else {
                    tag = new String("");
                }

                String group;
                if (request.getParameter("Group") != null && request.getParameter("Group").compareTo("All") != 0) {
                    group = request.getParameter("Group");
                    tcclauses = tcclauses + " AND `Group` = '" + request.getParameter("Group") + "'";
                    URL = URL + "&Group=" + group;
                } else {
                    group = new String("%%");
                }

                String port;
                if (request.getParameter("Port") != null && request.getParameter("Port").compareTo("") != 0) {
                    port = request.getParameter("Port");
                    execclauses = execclauses + " AND Port = '" + request.getParameter("Port") + "'";
                    URL = URL + "&Port=" + port;
                } else {
                    port = new String("");
                }
                String ip;
                if (request.getParameter("Ip") != null && request.getParameter("Ip").compareTo("") != 0) {
                    ip = request.getParameter("Ip");
                    execclauses = execclauses + " AND Ip = '" + request.getParameter("Ip") + "'";
                    URL = URL + "&Ip=" + ip;
                } else {
                    ip = new String("");
                }
                String browser;
                if (request.getParameter("browser") != null && request.getParameter("browser").compareTo("") != 0) {
                    browser = request.getParameter("browser");
                    execclauses = execclauses + " AND browser = '" + request.getParameter("browser") + "'";
                    URL = URL + "&Browser=" + browser;
                } else {
                    browser = new String("*firefox");
                }

                String logpath;
                if (request.getParameter("logpath") != null && request.getParameter("logpath").compareTo("") != 0) {
                    logpath = request.getParameter("logpath");
                    execclauses = execclauses + " AND logpath = '" + request.getParameter("logpath") + "'";
                } else {
                    logpath = new String("logpath");
                }

                String tcActive;
                if (request.getParameter("TcActive") != null && request.getParameter("TcActive").compareTo("A") != 0) {

                    tcActive = request.getParameter("TcActive");
                    tcclauses = tcclauses + " AND TcActive = '" + request.getParameter("TcActive") + "'";
                    URL = URL + "&TcActive=" + tcActive;
                    if (request.getParameter("TcActive").compareTo("A") == 0) {
                        tcActive = "%%";
                    }
                } else {
                    tcActive = new String("Y");
                }

                String readOnly;
                if (request.getParameter("ReadOnly") != null && request.getParameter("ReadOnly").compareTo("A") != 0) {
                    readOnly = request.getParameter("ReadOnly");
                    tcclauses = tcclauses + " AND ReadOnly = '" + request.getParameter("ReadOnly") + "'";
                    URL = URL + "&ReadOnly=" + readOnly;
                } else {
                    readOnly = new String("%%");
                }

                String priority;
                if (request.getParameter("Priority") != null) {
                    if (request.getParameter("Priority").compareTo("All") != 0) {
                        priority = request.getParameter("Priority");
                        tcclauses = tcclauses + " AND Priority = '" + request.getParameter("Priority") + "'";
                        URL = URL + "&Priority=" + priority;
                    } else {
                        priority = "%%";
                    }

                } else {
                    priority = new String("%%");
                }

                String environment;
                if (request.getParameter("Environment") != null && request.getParameter("Environment").compareTo("All") != 0) {
                    environment = request.getParameter("Environment");
                    execclauses = execclauses + " AND Environment = '" + request.getParameter("Environment") + "'";
                    URL = URL + "&Environment=" + environment;
                } else {
                    environment = new String("%%");
                }
                String revision;
                if (request.getParameter("Revision") != null && request.getParameter("Revision").compareTo("All") != 0) {
                    revision = request.getParameter("Revision");
                    execclauses = execclauses + " AND Revision = '" + request.getParameter("Revision") + "'";
                    URL = URL + "&Revision=" + revision;
                } else {
                    revision = new String("%%");
                }
                String creator;
                if (request.getParameter("Creator") != null && request.getParameter("Creator").compareTo("All") != 0) {
                    creator = request.getParameter("Creator");
                    tcclauses = tcclauses + " AND Creator = '" + request.getParameter("Creator") + "'";
                    URL = URL + "&Creator=" + creator;
                } else {
                    creator = new String("%%");
                }
                String implementer;
                if (request.getParameter("Implementer") != null && request.getParameter("Implementer").compareTo("All") != 0) {
                    implementer = request.getParameter("Implementer");
                    tcclauses = tcclauses + " AND Implementer = '" + request.getParameter("Implementer") + "'";
                    URL = URL + "&Implementer=" + implementer;
                } else {
                    implementer = new String("%%");
                }
                String build;
                if (request.getParameter("Build") != null && request.getParameter("Build").compareTo("All") != 0) {
                    build = request.getParameter("Build");
                    execclauses = execclauses + " AND Build = '" + request.getParameter("Build") + "'";
                    URL = URL + "&Build=" + build;
                } else {
                    build = new String("%%");
                }

                String project;
                if (request.getParameter("Project") != null && request.getParameter("Project").compareTo("All") != 0) {
                    project = request.getParameter("Project");
                    tcclauses = tcclauses + " AND Project = '" + request.getParameter("Project") + "'";
                    URL = URL + "&Project=" + project;
                } else {
                    project = new String("%%");
                }

                String app;
                if (request.getParameter("Application") != null && request.getParameter("Application").compareTo("All") != 0) {
                    app = request.getParameter("Application");
                    tcclauses = tcclauses + " AND tc.Application = '" + request.getParameter("Application") + "'";
                    URL = URL + "&Application=" + app;
                } else {
                    app = new String("%%");
                }

                String system;
                if (request.getParameter("System") != null && request.getParameter("System").compareTo("All") != 0) {
                    system = request.getParameter("System");
                    tcclauses = tcclauses + " AND a.System = '" + request.getParameter("System") + "'";
                    URL = URL + "&System=" + system;
                } else {
                    system = new String("%%");
                }

                String status;
                if (request.getParameter("Status") != null && request.getParameter("Status").compareTo("All") != 0) {
                    status = request.getParameter("Status");
                    tcclauses = tcclauses + " AND Status = '" + request.getParameter("Status") + "'";
                    URL = URL + "&Status=" + status;
                } else {
                    status = new String("%%");
                }

                String targetBuild = "";
                if (request.getParameter("TargetBuild") != null) {
                    if (request.getParameter("TargetBuild").compareTo("All") == 0) {
                        targetBuild = "All";
                    } else {
                        if (request.getParameter("TargetBuild").equals("NTB")) {
                            targetBuild = "";
                            tcclauses = tcclauses + " AND TargetBuild = '' ";
                            URL = URL + "&TargetBuild=" + targetBuild;
                        } else {
                            targetBuild = request.getParameter("TargetBuild");
                            tcclauses = tcclauses + " AND TargetBuild = '" + request.getParameter("TargetBuild") + "'";
                            URL = URL + "&TargetBuild=" + targetBuild;
                        }
                    }
                } else {
                    targetBuild = "All";
                    //tcclauses = tcclauses + " AND TargetBuild = '' ";
                }

                String targetRev = "";
                if (request.getParameter("TargetRev") != null) {
                    if (request.getParameter("TargetRev").compareTo("All") == 0) {
                        targetRev = "All";
                    } else {
                        if (request.getParameter("TargetRev").equals("NTR")) {
                            targetRev = "";
                            tcclauses = tcclauses + " AND TargetRev = '' ";
                            URL = URL + "&TargetRev=" + targetRev;
                        } else {
                            targetRev = request.getParameter("TargetRev");
                            tcclauses = tcclauses + " AND TargetRev = '" + request.getParameter("TargetRev") + "'";
                            URL = URL + "&TargetRev=" + targetRev;
                        }
                    }
                } else {
                    targetRev = "All";
                    //tcclauses = tcclauses + " AND TargetRev = '' ";
                }

                String test;
                if (request.getParameter("Test") != null && request.getParameter("Test").compareTo("All") != 0) {
                    test = request.getParameter("Test");
                    tcclauses = tcclauses + " AND test = '" + request.getParameter("Test") + "'";
                    URL = URL + "&Test=" + test;
                } else {
                    test = new String("%%");
                }
                String testcase;
                if (request.getParameter("TestCase") != null && request.getParameter("TestCase").compareTo("All") != 0) {
                    testcase = request.getParameter("TestCase");
                    tcclauses = tcclauses + " AND testcase = '" + request.getParameter("testcase") + "'";
                } else {
                    testcase = new String("%%");
                }
                String[] country_list = null;
                if (request.getParameter("Country") != null) {
                    country_list = request.getParameterValues("Country");
                } else {
                    country_list = new String[0];
                }

                for (int i = 0; i < country_list.length; i++) {
                    URL = URL + "&Country=" + country_list[i];
                }

                List<String> statistiques = new ArrayList<String>();

                Boolean apply;
                if (request.getParameter("Apply") != null
                        && request.getParameter("Apply").compareTo("Apply") == 0) {
                    apply = true;
                } else {
                    apply = false;
                }

                Boolean recordPref;
                if (request.getParameter("RecordPref") != null
                        && request.getParameter("RecordPref").compareTo("Y") == 0) {
                    recordPref = true;
                } else {
                    recordPref = false;
                }
                String reportingFavorite = "ReportingExecution.jsp?";

                Connection conn = db.connect();
                try {

                    Statement stmt = conn.createStatement();
                    Statement stmt33 = conn.createStatement();

                    IApplicationService myApplicationService = appContext.getBean(IApplicationService.class);
                    String SitdmossBugtrackingURL;
                    String SitdmossBugtrackingURL_tc;
                    SitdmossBugtrackingURL_tc = "";

                    Statement stmt1 = conn.createStatement();
                    ResultSet rs_testcasecountrygeneral = stmt1.executeQuery("SELECT value "
                            + " FROM invariant "
                            + " WHERE idname ='COUNTRY'"
                            + " ORDER BY sort asc");
                    ResultSet rsPref = stmt33.executeQuery("SELECT ReportingFavorite from user where "
                            + " login = '"
                            + request.getUserPrincipal().getName()
                            + "'");

                    Statement stmt5 = conn.createStatement();

                    insertURL = "UPDATE USER SET ReportingFavorite = '"
                            + URL + "' where login = '"
                            + request.getUserPrincipal().getName()
                            + "'";
                    if (recordPref == true) {
                        stmt5.execute(insertURL);
                    }


            %>
            <form method="GET" name="Apply" action="ReportingExecution.jsp">
                <table id="arrond">
                    <tr><td id="arrond"><h3 style="color:blue">Filters</h3>
                            <table border="0px">
                                <tr>
                                    <td id="wob" style="width: 110px"><%out.print(dbDocS(conn, "runnerpage", "Test", "Test"));%></td>
                                    <td id="wob" style="width: 70px"><%out.print(dbDocS(conn, "runnerpage", "Project", "Project"));%></td>
                                    <td id="wob" style="width: 60px"><%out.print(dbDocS(conn, "application", "System", "System"));%></td>
                                    <td id="wob" style="width: 100px"><%out.print(dbDocS(conn, "runnerpage", "Application", "Application"));%></td>
                                    <td id="wob" style="width: 70px"><%out.print(dbDocS(conn, "runnerpage", "Read Only", "Read Only"));%></td>
                                    <td id="wob" style="width: 70px"><%out.print(dbDocS(conn, "runnerpage", "TestCaseActive", "TestCase Active"));%></td>
                                    <td id="wob" style="width: 70px"><%out.print(dbDocS(conn, "runnerpage", "Priority", "Priority"));%></td>
                                    <td id="wob" style="width: 110px"><%out.print(dbDocS(conn, "testcase", "Status", "Status"));%></td>
                                    <td id="wob" style="width: 110px"><%out.print(dbDocS(conn, "testcase", "Group", "Group"));%></td>
                                    <td id="wob" style="width: 110px"><%out.print(dbDocS(conn, "testcase", "targetBuild", "targetBuild"));%></td>                        
                                    <td id="wob" style="width: 110px"><%out.print(dbDocS(conn, "testcase", "targetRev", "targetRev"));%></td>                        
                                    <td id="wob" style="width: 100px"><%out.print(dbDocS(conn, "testcase", "creator", "Creator"));%></td>
                                    <td id="wob" style="width: 100px"><%out.print(dbDocS(conn, "testcase", "implementer", "implementer"));%></td>
                                </tr>

                                <tr>                        
                                    <td id="wob">
                                        <select id="test" style="width: 110px"  name="Test">
                                            <option value="All">-- ALL --</option><%
                                                String optstyle = "";
                                                ResultSet rsTest = stmt.executeQuery("SELECT Test, active FROM Test where Test IS NOT NULL Order by Test asc");
                                                while (rsTest.next()) {
                                                    if (rsTest.getString("active").equalsIgnoreCase("Y")) {
                                                        optstyle = "font-weight:bold;";
                                                    } else {
                                                        optstyle = "font-weight:lighter;";
                                                    }%>
                                            <option style="width: 200px;<%=optstyle%>" value="<%= rsTest.getString(1)%>" <%=test.compareTo(rsTest.getString(1)) == 0 ? " SELECTED " : ""%>><%= rsTest.getString(1)%></option><%
                                                }%>
                                        </select>
                                    </td>
                                    <td id="wob">
                                        <% out.print(ComboProject(conn, "Project", "width: 70px", "project", "", project, "", true, "All", "-- ALL --"));%>
                                    </td>
                                    <td id="wob">
                                        <select id="system" style="width: 50px"  name="System">
                                            <option value="All">-- ALL --</option><%
                                                ResultSet rsSys = stmt.executeQuery("SELECT DISTINCT System FROM Application Order by System asc");
                                                while (rsSys.next()) {%>
                                            <option value="<%= rsSys.getString("System")%>" <%=system.compareTo(rsSys.getString("System")) == 0 ? " SELECTED " : ""%>><%= rsSys.getString("System")%></option><%
                                                }%>
                                        </select>
                                    </td>
                                    <td id="wob">
                                        <select id="application" style="width: 100px"  name="Application">
                                            <option value="All">-- ALL --</option><%
                                                ResultSet rsApp = stmt.executeQuery("SELECT Application , System FROM Application Order by Sort asc");
                                                while (rsApp.next()) {%>
                                            <option value="<%= rsApp.getString("Application")%>" <%=app.compareTo(rsApp.getString("Application")) == 0 ? " SELECTED " : ""%>><%= rsApp.getString("Application")%> [<%= rsApp.getString("System")%>]</option><%
                                                }%>
                                        </select>
                                    </td>
                                    <td id="wob">
                                        <select style="width: 70px" id="readonly" name="ReadOnly">
                                            <option value="A" <%=readOnly.compareTo("A") == 0 ? " SELECTED " : ""%>>-- ALL --</option>
                                            <option value="Y" <%=readOnly.compareTo("Y") == 0 ? " SELECTED " : ""%>>Y</option>
                                            <option value="N" <%=readOnly.compareTo("N") == 0 ? " SELECTED " : ""%>>N</option>
                                        </select>
                                    </td>
                                    <td id="wob">
                                        <select style="width: 70px" id="active_tc" name="TcActive">
                                            <option value="A" <%=tcActive.compareTo("A") == 0 ? " SELECTED " : ""%>>-- ALL --</option>
                                            <option value="Y" <%=tcActive.compareTo("Y") == 0 ? " SELECTED " : ""%>>Y</option>
                                            <option value="N" <%=tcActive.compareTo("N") == 0 ? " SELECTED " : ""%>>N</option>
                                        </select>
                                    </td>
                                    <td id="wob">
                                        <select style="width: 70px" id="priority" name="Priority">
                                            <option value="All">-- ALL --</option><%
                                                ResultSet rsPri = stmt.executeQuery("SELECT DISTINCT value FROM invariant WHERE id=15 Order by sort asc");
                                                while (rsPri.next()) {%>
                                            <option value="<%= rsPri.getString(1)%>" <%=priority.compareTo(rsPri.getString(1)) == 0 ? " SELECTED " : ""%>><%= rsPri.getString(1)%></option><%
                                                }%>
                                        </select>
                                    </td>
                                    <td id="wob">
                                        <select style="width: 110px" id="status" name="Status">
                                            <option value="All">-- ALL --</option><%
                                                ResultSet rsStatus = stmt.executeQuery("SELECT value from Invariant where id = 1 order by sort asc");
                                                while (rsStatus.next()) {%>
                                            <option value="<%= rsStatus.getString(1)%>" <%=status.compareTo(rsStatus.getString(1)) == 0 ? " SELECTED " : ""%>><%= rsStatus.getString(1)%></option><%
                                                }%>
                                        </select>
                                    </td>

                                    <td id="wob">
                                        <select style="width: 110px" id="group" name="Group">
                                            <option value="All">-- ALL --</option><%
                                                ResultSet rsGroup = stmt.executeQuery("SELECT value from Invariant where id = 2 order by sort");
                                                while (rsGroup.next()) {%>
                                            <option value="<%= rsGroup.getString(1)%>" <%=group.compareTo(rsGroup.getString(1)) == 0 ? " SELECTED " : ""%>><%= rsGroup.getString(1)%></option><%
                                                }%>
                                        </select>
                                    </td>
                                    <td id="wob">
                                        <select style="width: 110px" id="targetBuild" name="TargetBuild">
                                            <option value="All" <%=targetBuild.equals("All") == true ? " SELECTED " : ""%>>-- ALL --</option>
                                            <option value="NTB" <%=targetBuild.equals("") == true ? " SELECTED " : ""%>>--No Target Build--</option>
                                            <% ResultSet rsTargetBuild = stmt.executeQuery("SELECT value from Invariant where idname = 'Build' order by sort");
                                                while (rsTargetBuild.next()) {%>
                                            <option value="<%= rsTargetBuild.getString(1)%>" <%=targetBuild.compareTo(rsTargetBuild.getString(1)) == 0 ? " SELECTED " : ""%>><%= rsTargetBuild.getString(1)%></option><%
                                                }%>
                                        </select>
                                    </td>
                                    <td id="wob">
                                        <select style="width: 110px" id="targetRev" name="TargetRev">
                                            <option value="All" <%=targetRev.compareTo("All") == 0 ? " SELECTED " : ""%>>-- ALL --</option>
                                            <option value="NTR" <%=targetRev.compareTo("") == 0 ? " SELECTED " : ""%>>--No Target Rev--</option>
                                            <% ResultSet rsTargetRev = stmt.executeQuery("SELECT value from Invariant where idname = 'Revision' order by sort");
                                                while (rsTargetRev.next()) {%>
                                            <option value="<%= rsTargetRev.getString(1)%>" <%=targetRev.compareTo(rsTargetRev.getString(1)) == 0 ? " SELECTED " : ""%>><%= rsTargetRev.getString(1)%></option><%
                                                }%>
                                        </select>
                                    </td>
                                    <td id="wob">
                                        <select style="width: 100px" id="creator" name="Creator">
                                            <option value="All" <%=creator.compareTo("All") == 0 ? " SELECTED " : ""%>>-- ALL --</option><%
                                                ResultSet rsCreator = stmt.executeQuery("SELECT login from user");
                                                while (rsCreator.next()) {%>
                                            <option value="<%= rsCreator.getString(1)%>" <%=creator.compareTo(rsCreator.getString(1)) == 0 ? " SELECTED " : ""%>><%= rsCreator.getString(1)%></option><%
                                                }%>
                                        </select>
                                    </td>
                                    <td id="wob">
                                        <select style="width: 100px" id="implementer" name="Implementer">
                                            <option value="All" <%=implementer.compareTo("All") == 0 ? " SELECTED " : ""%>>-- ALL --</option><%
                                                rsCreator.first();
                                                while (rsCreator.next()) {%>
                                            <option value="<%= rsCreator.getString(1)%>" <%=implementer.compareTo(rsCreator.getString(1)) == 0 ? " SELECTED " : ""%>><%= rsCreator.getString(1)%></option><%
                                                }%>
                                        </select>
                                    </td>
                                </tr>
                            </table>
                            <table border="0px">
                                <tr><td colspan="7" class="wob"></td></tr>
                                <tr>
                                    <td id="wob" style="width: 130px"><%out.print(dbDocS(conn, "runnerpage", "Environment", "Environment"));%></td>
                                    <td id="wob" style="width: 130px"><%out.print(dbDocS(conn, "runnerpage", "Build", "Build"));%></td>
                                    <td id="wob" style="width: 130px"><%out.print(dbDocS(conn, "runnerpage", "Revision", "Revision"));%></td>
                                    <td id="wob" style="width: 130px"><%out.print(dbDocS(conn, "testcaseexecution", "IP", "Ip"));%></td>
                                    <td id="wob" style="width: 130px"><%out.print(dbDocS(conn, "testcaseexecution", "Port", "Port"));%></td>
                                    <td id="wob" style="width: 130px"><%out.print(dbDocS(conn, "runnerpage", "Tag", "Tag"));%></td>
                                </tr>

                                <tr>
                                    <td id="wob">
                                        <select id="environment" name="Environment" style="width: 130px">
                                            <option style="width: 130px" value="All">-- ALL --</option>
                                            <% ResultSet rsEnv = stmt.executeQuery("SELECT value from Invariant where id = 5 order by sort");
                                                while (rsEnv.next()) {%>
                                            <option style="width: 130px" value="<%= rsEnv.getString(1)%>" <%=environment.compareTo(rsEnv.getString(1)) == 0 ? " SELECTED " : ""%>><%= rsEnv.getString(1)%></option><%
                                                }%>
                                        </select>
                                    </td>
                                    <td id="wob">
                                        <select id="build" name="Build" style="width: 130px">
                                            <option style="width: 130px" value="All">-- ALL --</option>
                                            <% ResultSet rsBuild = stmt.executeQuery("SELECT value from Invariant where id = 8 order by sort");
                                                while (rsBuild.next()) {%>
                                            <option style="width: 130px" value="<%= rsBuild.getString(1)%>" <%=build.compareTo(rsBuild.getString(1)) == 0 ? " SELECTED " : ""%>><%= rsBuild.getString(1)%></option><%
                                                }%>
                                        </select>
                                    </td>
                                    <td id="wob">
                                        <select id="revision" name="Revision" style="width: 130px">
                                            <option style="width: 130px" value="All">-- ALL --</option>
                                            <% ResultSet rsRev = stmt.executeQuery("SELECT value from Invariant where id = 9 order by sort");
                                                while (rsRev.next()) {%>
                                            <option style="width: 130px" value="<%= rsRev.getString(1)%>" <%=revision.compareTo(rsRev.getString(1)) == 0 ? " SELECTED " : ""%>><%= rsRev.getString(1)%></option><%
                                                }%>
                                        </select>
                                    </td>
                                    <td id="wob"><input style="font-weight: bold; width: 130px" name="Ip" id="Ip" value="<%=ip%>"></td>
                                    <td id="wob"><input style="font-weight: bold; width: 60px" name="Port" id="Port" value="<%=port%>"></td>
                                    <td id="wob"><input style="font-weight: bold; width: 130px" name="Tag" id="Tag" value="<%=tag%>"></td>
                                </tr>
                            </table>
                            <%
                            %>
                            <table border="0px">
                                <tr><td></td></tr>
                                <tr>
                                    <td id ="arrond">
                                        <table>
                                            <tr><td class="wob" colspan="4"><h4 style="color:black">Country</h4></td></tr>
                                            <tr><%

                                                rs_testcasecountrygeneral.first();
                                                do {%>
                                                <td class="wob" style="font-size : x-small ; width: 10px;"><%=rs_testcasecountrygeneral.getString("value")%></td><%
                                                    } while (rs_testcasecountrygeneral.next());
                                                %></tr>
                                            <tr><%

                                                rs_testcasecountrygeneral.first();
                                                do {
                                                                   %>
                                                                   <td class="wob"><input value="<%=rs_testcasecountrygeneral.getString("value")%>" type="checkbox" <%
                                                                       for (int i = 0; i < country_list.length; i++) {
                                                            if (country_list[i].equals(rs_testcasecountrygeneral.getString("value"))) {%> CHECKED <%}
                                                                                 }%> name="Country" ></td><%
                                                                             } while (rs_testcasecountrygeneral.next());
                                                    %>
                                                <td id="wob"><input id="button" type="button" value="All" onclick="selectAll('country',true)"><input id="button" type="button" value="None" onclick="selectAll('country',false)"></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td id="wob">
                                        <table>
                                            <tr>
                                                <td class="wob">
                                                    <input id="button" type="submit" name="Apply" value="Apply">
                                                </td>
                                                <%if (!apply) {
                                                        if (rsPref.first()) {
                                                            if (StringUtils.isNotBlank(rsPref.getString("ReportingFavorite"))) {
                                                                reportingFavorite = reportingFavorite + rsPref.getString("ReportingFavorite");
                                                            }
                                                %>
                                                <td class="wob">
                                                    <input id="button" type="button" name="defaultFilter" value="Select My Default Filters" onclick="loadReporting('<%=reportingFavorite%>')">           
                                                </td><% }
                                                } else {
                                                    if (rsPref.first()) {
                                                        if (StringUtils.isNotBlank(rsPref.getString("ReportingFavorite"))) {
                                                            reportingFavorite = reportingFavorite + rsPref.getString("ReportingFavorite");
                                                            if (URL.compareTo(rsPref.getString("ReportingFavorite")) != 0) {

                                                                enable = "";
                                                            }
                                                        } else {
                                                            enable = "";
                                                        }
                                                %>
                                                <td class="wob">
                                                    <input id="button" type="button" <%=enable%> value="Set As My Default Filter" onclick="loadReporting('ReportingExecution.jsp?RecordPref=Y&<%=URL%>')">
                                                </td><%}
                                                    }%>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>                                   

                <br><br>
                <%
                    if (apply) {
                %>
                <table  class="arrond" >
                    <tr>
                        <td id="wob">
                            <table>
                                <tr>
                                    <td id="wob">
                                        <input id="ShowS" type="button" value="Show Summary" onclick="javascript:setInvisibleRep();" style="display:table">
                                        <input id="ShowD" type="button" value="Show Details" onclick="javascript:setVisibleRep();" style="display:none">
                                    </td>
                                    <td id="wob">Legend : </td>
                                    <td id="wob" class="OK" title="OK : Test was fully executed and no bug are to be reported."><a class="OKF">OK</a></td>
                                    <td id="wob" class="KO" title="KO : Test was executed and bug have been detected."><a class="KOF">KO</a></td>
                                    <td id="wob" class="NA" title="NA : Test could not be executed because some test data are not available."><a class="NAF">NA</a></td>
                                    <td id="wob" class="FA" title="FA : Test could not be executed because there is a bug on the test."><a class="FAF">FA</a></td>
                                    <td id="wob" class="PE" title="PE : Test execution is still running..."><a class="PEF">PE</a></td>
                                    <td id="wob" class="NotExecuted" title="Test Case has not been executed for that country."><a class="NotExecutedF">XX</a></td>
                                    <td id="wob" class="NOINF" title="Test Case not available for the country XX."><a class="NOINFF">XX</a></td>
                                </tr>
                            </table>
                        </td>
                    </tr>    
                    <tr>
                        <td id="wob">
                            <table id="reportingExec" style="text-align: left;border-collapse:collapse;display:table" border="1px" cellpadding="0" cellspacing="1">
                                <tr id="header">
                                    <td style="width: 30px"><%out.print(dbDocS(conn, "testcase", "test", "Test"));%></td>
                                    <td style="width: 30px"><%out.print(dbDocS(conn, "testcase", "testcase", "TestCase"));%></td>
                                    <td style="width: 30px"><%out.print(dbDocS(conn, "testcase", "application", "Aplication"));%></td>
                                    <td style="width: 30px"><%out.print(dbDocS(conn, "testcase", "description", "Description"));%></td>
                                    <td style="width: 30px"><%out.print(dbDocS(conn, "testcase", "priority", "Priority"));%></td>
                                    <td style="width: 30px"><%out.print(dbDocS(conn, "testcase", "status", "Status"));%></td>
                                    <%
                                        //rs_testcasecountrygeneral.first();								
                                        //do {
                                        for (int i = 0; i < country_list.length; i++) {
                                    %> 
                                    <td class="header"> 
                                        <%=country_list[i]%> </td>
                                    <td class="header" style="font-size : x-small ;">Reporting Execution</td>
                                    <%
                                        }
                                        // } while (rs_testcasecountrygeneral.next());

                                    %>
                                    <td style="width: 30px"><%out.print(dbDocS(conn, "testcase", "comment", "Comment"));%></td> 
                                    <td style="width: 30px"><%out.print(dbDocS(conn, "testcase", "bugID", "BugID"));%></td>
                                </tr>
                                <%
                                    //out.println(tcclauses);
                                    // out.println(avgclauses);
                                    //out.println(execclauses);
                                    int j = 0;
                                    String stats = "";
                                    String testlist = "";
                                    String countrylist = "";
                                    String statuslist = "";
                                    Statement stmt2 = conn.createStatement();
                                    ResultSet rs_time = stmt2.executeQuery("select tc.test, tc.testcase, "
                                            + " tc.application, tc.description, tc.behaviororvalueexpected, tc.Status, "
                                            + " tc.priority, tc.comment, tc.bugID, tc.TargetBuild, tc.TargetRev "
                                            + " from testcase tc "
                                            + " join application a on a.application = tc.application "
                                            + tcclauses
                                            + " and tc.group != 'PRIVATE' "
                                            + " order by tc.test, tc.testcase ");

                                    Statement stmt8 = conn.createStatement();
                                    ResultSet rs_test = stmt8.executeQuery("select distinct test "
                                            + " from testcase tc "
                                            + " join application a on a.application = tc.application "
                                            + tcclauses
                                            + " and tc.group != 'PRIVATE' "
                                            + " order by test ");
                                    if (rs_time.first()) {
                                        //if (StringUtils.isNotBlank(rs_time.getString("tc.test")) == true){ 
                                        if (rs_test.first())
                                            do {
                                                if (!rs_test.getString("test").equals(rs_time.getString("tc.test"))) {%>
                                <tr id="header">
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <%
                                        for (int i = 0; i < country_list.length; i++) {
                                    %> 
                                    <td colspan="2" style="text-align: center"> 
                                        <%=country_list[i]%> </td>
                                        <%}%>
                                    <td></td>
                                    <td></td>
                                </tr>

                                <%
                                        j = 0;
                                        rs_test.next();
                                    }
                                    if (j == 12) {%>
                                <tr style="font-size : x-small ;">
                                    <td class="INF"></td>
                                    <td class="INF"></td>
                                    <td class="INF"></td>
                                    <td class="INF"></td>
                                    <td class="INF"></td>
                                    <td class="INF"></td>
                                    <%
                                        for (int i = 0; i < country_list.length; i++) {
                                    %> 
                                    <td class="INF" colspan="2" style="text-align: center"> 
                                        <%=country_list[i]%> </td>

                                    <%}%>
                                    <td class="INF"></td>
                                    <td class="INF"></td>
                                </tr>

                                <%
                                        j = 0;
                                    }
                                    String toto = "" + rs_time.getString("tc.behaviororvalueexpected");
                                %>
                                <tr>
                                    <td class="INF" style="width: 30px"><%=rs_time.getString("tc.test")%></td>
                                    <td class="INF" style="width: 30px"><a href="TestCase.jsp?Load=Load&Test=<%=rs_time.getString("tc.test")%>&TestCase=<%=rs_time.getString("tc.testcase")%>"> <%=rs_time.getString("tc.testcase")%></a></td>
                                    <td class="INF" style="width: 30px"><%=rs_time.getString("tc.application")%></td>
                                    <td class="INF" style="width: 30px" title="<%=toto%>"><%=rs_time.getString("tc.description")%></td>
                                    <td class="INF" style="width: 30px"><%=rs_time.getString("tc.Priority")%></td>
                                    <td class="INF" style="width: 30px"><%=rs_time.getString("tc.Status")%></td>
                                    <%

                                        rs_testcasecountrygeneral.first();
                                        String cssStatus = "";
                                        String color = "black";
                                        Statement stmt4 = conn.createStatement();
                                        ResultSet rs_count = stmt4.executeQuery("select country "
                                                + " from testcasecountry where "
                                                + " test = '"
                                                + rs_time.getString("tc.Test")
                                                + "' and testcase = '"
                                                + rs_time.getString("tc.testcase")
                                                + "' order by country asc");
                                        if (rs_count.first()) {
                                            cssStatus = "NE";
                                            color = "black";

                                            rs_count.last();
                                            int rownumber = rs_count.getRow();
                                            rs_count.first();
                                            for (int i = 0; i < country_list.length; i++) {

                                                while (rs_count.getString("Country").compareTo(country_list[i]) < 0 && rs_count.getRow() < rownumber) {
                                                    if (!rs_count.isAfterLast()) {
                                                        rs_count.next();
                                                    }
                                                }


                                                //    if(rs_count.isLast()) {} else { rs_count.next(); }

                                                if (country_list[i].equals(rs_count.getString("country"))) {
                                                    //out.println(execclauses);
                                                    Statement stmt3 = conn.createStatement();
                                                    ResultSet rs_exec = stmt3.executeQuery("select ID, test, testcase, application, "
                                                            + "ControlStatus, DATE_FORMAT(Start,'%Y-%m-%d %H:%i') as Start, DATE_FORMAT(End,'%Y-%m-%d %H:%i') as End "
                                                            + " from testcaseexecution where "
                                                            + execclauses
                                                            + " and test = '"
                                                            + rs_time.getString("tc.Test")
                                                            + "' and testcase = '"
                                                            + rs_time.getString("tc.testcase")
                                                            + "' and country = '"
                                                            + country_list[i]
                                                            + "' order by ID desc");
                                                    if (rs_exec.first()) {
                                                        if (StringUtils.isNotBlank(rs_exec.getString("ID"))) {
                                                            cssStatus = "NotExecuted";
                                                            color = "black";
                                                            if (rs_exec.getString("ControlStatus").equals("OK")) {
                                                                cssStatus = "OK";
                                                                color = "green";
                                                            } else if (rs_exec.getString("ControlStatus").equals("KO")) {
                                                                cssStatus = "KO";
                                                                color = "darkred";
                                                            } else if (rs_exec.getString("ControlStatus").equals("NA")) {
                                                                cssStatus = "NA";
                                                                color = "darkyellow";
                                                            } else if (rs_exec.getString("ControlStatus").equals("FA")) {
                                                                cssStatus = "FA";
                                                                color = "darkmagenta";
                                                            } else if (rs_exec.getString("ControlStatus").equals("PE")) {
                                                                cssStatus = "PE";
                                                                color = "darkblue";
                                                            }

                                                            if ((rs_time.getString("tc.BugID") != null)
                                                                    && (rs_time.getString("tc.BugID").compareToIgnoreCase("") != 0)
                                                                    && (rs_time.getString("tc.BugID").compareToIgnoreCase("null") != 0)) {
                                                                SitdmossBugtrackingURL = myApplicationService.findApplicationByKey(rs_exec.getString("application")).getBugTrackerUrl();
                                                                SitdmossBugtrackingURL_tc = SitdmossBugtrackingURL.replaceAll("%bugid%", rs_time.getString("tc.BugID"));
                                                            } else {
                                                                SitdmossBugtrackingURL_tc = "";
                                                            }
                                                            testlist = rs_time.getString("tc.test");
                                                            countrylist = country_list[i];
                                                            statuslist = rs_exec.getString("ControlStatus");
                                                            stats = testlist + "-" + countrylist + "-" + statuslist;
                                                            statistiques.add(i, stats);
                                    %> 
                                    <td class="<%=cssStatus%>"> 
                                        <a href="ExecutionDetail.jsp?id_tc=<%=rs_exec.getString("ID")%>" class="<%=cssStatus%>F"><%=rs_exec.getString("ControlStatus")%></a>
                                    </td>
                                    <td class="INF" style="font-size : x-small"> <%=rs_exec.getString("Start")%></td>
                                    <%
                                            stmt3.close();
                                        }
                                    } else {
                                        statistiques.add(i, rs_time.getString("tc.test") + "-" + country_list[i] + "-" + "NE");
                                        cssStatus = "NotExecuted";%>
                                    <td class="<%=cssStatus%>"><a href="RunTests.jsp?Test=<%=rs_time.getString("tc.test")%>&TestCase=<%=rs_time.getString("tc.testcase")%>&Country=<%=country_list[i]%>" class="<%=cssStatus%>F"><%= country_list[i]%></a></td>
                                    <td class="INF"></td>
                                    <%    }
                                        if (rs_count.isLast() == true) {
                                        } else {
                                            rs_count.next();
                                        }
                                    } else {
                                        // if (rs_count.getString("Country").compareTo(country_list[i]) > 0){
                                        //    if(rs_count.isLast()) {} else { rs_count.next(); }

                                        statistiques.add(i, rs_time.getString("tc.test") + "-" + country_list[i] + "-" + "NT");

                                    %>
                                    <td class="NOINF"></td><td class="NOINF"></td>
                                    <%   }// }   
                                        }
                                    %>
                                        <td class="INF" style="width: 30px"><%
                                        if (rs_time.getString("tc.Comment") != null) {%><%=rs_time.getString("tc.Comment")%><%}%></td>
                                        <td class="INF" style="width: 30px"><%
                                            if (SitdmossBugtrackingURL_tc.equalsIgnoreCase("") == false) {%><a href="<%=SitdmossBugtrackingURL_tc%>" target="_blank"><%=rs_time.getString("tc.BugID")%></a><%
                                            }
                                            if ((rs_time.getString("tc.TargetBuild") != null) && (rs_time.getString("tc.TargetBuild").equalsIgnoreCase("") == false)) {
                                        %> for <%=rs_time.getString("tc.TargetBuild")%>/<%=rs_time.getString("tc.TargetRev")%><%
                                        }%></td>   
                                </tr>

                                <%
                                } else {
                                    // do{
                                    for (int i = 0; i < country_list.length; i++) {
                                %>
                                <td class="NOINF"></td><td class="NOINF"></td>
                                <%                                                              }
                                %>
                                <td class="INF" style="width: 30px"><%
                                    if (rs_time.getString("tc.Comment") != null) {%><%=rs_time.getString("tc.Comment")%><%}%></td>
                                <td class="INF" style="width: 30px"><%
                                    if (SitdmossBugtrackingURL_tc.equalsIgnoreCase("") == false) {%><a href="<%=SitdmossBugtrackingURL_tc%>" target="_blank"><%=rs_time.getString("tc.BugID")%></a><%
                                        }
                                        if ((rs_time.getString("tc.TargetBuild") != null) && (rs_time.getString("tc.TargetBuild").equalsIgnoreCase("") == false)) {
                                    %> for <%=rs_time.getString("tc.TargetBuild")%>/<%=rs_time.getString("tc.TargetRev")%><%
                                        }%></td>  

                                <%    }
                                                j++;
                                                stmt4.close();
                                            } while (rs_time.next());
                                    }
                                %>
                            </table>
                            <table id="execReporting" style="display: none" border="0px" cellpadding="0" cellspacing="0">
                                <tr id="header">
                                    <td></td>
                                    <%
                                        for (int i = 0; i < country_list.length; i++) {
                                    %>
                                    <td colspan="3" align="center" style="width: 60px ;"><%=country_list[i]%></td>
                                    <%
                                        }
                                    %>
                                </tr>
                                <tr id="header">
                                    <td>Tests</td>
                                    <%
                                        for (int i = 0; i < country_list.length; i++) {
                                    %>
                                    <td id="repsynthesis1" align="center" style="width: 20px ;color : green">OK</td>
                                    <td id="repsynthesis2" align="center" style="width: 20px ;color : red">KO</td>
                                    <td id="repsynthesis3" align="center" style="width: 20px ;color : #999999">NE</td>
                                    <%                                                              }
                                    %>
                                </tr>
                                <%
                                    String[] statsdetails = {"", ""};
                                    for (int k = 0; k < country_list.length; k++) {
                                        String OK = "OK" + country_list[k];
                                        String KO = "KO" + country_list[k];
                                        String NE = "NE" + country_list[k];
                                        String NT = "NT" + country_list[k];
                                    }

                                    List<String> listtest = new ArrayList<String>();




                                    for (int i = 0; i < statistiques.size(); i++) {
                                        statsdetails = statistiques.get(i).split("-");
                                        listtest.add(statsdetails[0]);
                                    }
                                    Set set = new HashSet();
                                    set.addAll(listtest);
                                    ArrayList distinctList = new ArrayList(set);
                                    Collections.sort(distinctList);

                                    List<String> listTOTOK = new ArrayList<String>();
                                    List<String> listTOTKO = new ArrayList<String>();
                                    List<String> listTOTNE = new ArrayList<String>();
                                    List<String> listTOTNT = new ArrayList<String>();

                                    for (int l = 0; l < distinctList.size(); l++) {
                                        List<String> listOK = new ArrayList<String>();
                                        List<String> listKO = new ArrayList<String>();
                                        List<String> listNE = new ArrayList<String>();
                                        List<String> listNT = new ArrayList<String>();
                                        for (int i = 0; i < statistiques.size(); i++) {
                                            statsdetails = statistiques.get(i).split("-");
                                            String countrystatus = statsdetails[1] + "-" + statsdetails[2];

                                            if (distinctList.get(l).equals(statsdetails[0])) {
                                                if (statsdetails[2].equals("OK")) {
                                                    listOK.add(countrystatus);
                                                    listTOTOK.add(countrystatus);
                                                }
                                                if (statsdetails[2].equals("KO")) {
                                                    listKO.add(countrystatus);
                                                    listTOTKO.add(countrystatus);
                                                }
                                                if (statsdetails[2].equals("NE")) {
                                                    listNE.add(countrystatus);
                                                    listTOTNE.add(countrystatus);
                                                }
                                                if (statsdetails[2].equals("NT")) {
                                                    listNT.add(countrystatus);
                                                    listTOTNT.add(countrystatus);
                                                }

                                            }
                                        }

                                %>
                                <tr>
                                    <td><%=distinctList.get(l)%></td>
                                    <%
                                        for (int b = 0; b < country_list.length; b++) {
                                            List<String> listCTOK = new ArrayList<String>();
                                            List<String> listCTKO = new ArrayList<String>();
                                            List<String> listCTNE = new ArrayList<String>();
                                            List<String> listCTNT = new ArrayList<String>();

                                            for (int a = 0; a < listOK.size(); a++) {
                                                String[] CTOKdetails = listOK.get(a).split("-");
                                                if (country_list[b].equals(CTOKdetails[0])) {
                                                    if (CTOKdetails[1].equals("OK")) {
                                                        listCTOK.add(CTOKdetails[1]);
                                                    }
                                                }
                                            }

                                            for (int a = 0; a < listKO.size(); a++) {
                                                String[] CTKOdetails = listKO.get(a).split("-");
                                                if (country_list[b].equals(CTKOdetails[0])) {
                                                    if (CTKOdetails[1].equals("KO")) {
                                                        listCTKO.add(CTKOdetails[1]);
                                                    }
                                                }
                                            }

                                            for (int a = 0; a < listNE.size(); a++) {
                                                String[] CTNEdetails = listNE.get(a).split("-");
                                                if (country_list[b].equals(CTNEdetails[0])) {
                                                    if (CTNEdetails[1].equals("NE")) {
                                                        listCTNE.add(CTNEdetails[1]);
                                                    }
                                                }
                                            }

                                            for (int a = 0; a < listNT.size(); a++) {
                                                String[] CTNTdetails = listNT.get(a).split("-");
                                                if (country_list[b].equals(CTNTdetails[0])) {
                                                    if (CTNTdetails[1].equals("NT")) {
                                                        listCTNT.add(CTNTdetails[1]);
                                                    }
                                                }
                                            }
                                            String cssGen = "White";
                                            String cssleftTOP = "";
                                            String cssleftRIG = "";
                                            String cssmiddleTOP = "";
                                            String cssmiddleRIG = "";
                                            String cssmiddleLEF = "";
                                            String cssrightTOP = "";
                                            String cssrightLEF = "";

                                            if (listCTKO.size() != 0) {
                                                cssGen = "#FF0000";
                                                cssleftTOP = "#FF0000";
                                                cssleftRIG = "#FF0000";
                                                cssmiddleTOP = "FF0000";
                                                cssmiddleRIG = "FF0000";
                                                cssmiddleLEF = "FF0000";
                                                cssrightTOP = "FF0000";
                                                cssrightLEF = "FF0000";
                                            } else {
                                                if (listCTNE.size() != 0) {
                                                    cssGen = "whitesmoke";
                                                    cssleftTOP = "whitesmoke";
                                                    cssleftRIG = "whitesmoke";
                                                    cssmiddleTOP = "whitesmoke";
                                                    cssmiddleRIG = "whitesmoke";
                                                    cssmiddleLEF = "whitesmoke";
                                                    cssrightTOP = "whitesmoke";
                                                    cssrightLEF = "whitesmoke";
                                                } else {
                                                    if (listCTOK.size() != 0) {
                                                        cssGen = "#00FF00";
                                                        cssleftTOP = "#00FF00";
                                                        cssleftRIG = "#00FF00";
                                                        cssmiddleTOP = "#00FF00";
                                                        cssmiddleRIG = "#00FF00";
                                                        cssmiddleLEF = "#00FF00";
                                                        cssrightTOP = "#00FF00";
                                                        cssrightLEF = "#00FF00";
                                                    } else {
                                                        cssGen = "White";
                                                        cssleftTOP = "White";
                                                        cssleftRIG = "White";
                                                        cssmiddleTOP = "White";
                                                        cssmiddleRIG = "White";
                                                        cssmiddleLEF = "White";
                                                        cssrightTOP = "White";
                                                        cssrightLEF = "White";
                                                    }
                                                }

                                            }

                                    %>                          <td id="repsynthesis1" class="INF" align="center" style="font : bold  ; width : 20px 
                                        ; background-color: <%=cssGen%>; border-top-color: <%=cssleftTOP%> ; border-right-color: <%=cssleftRIG%>  ">
                                        <%=listCTOK.size() != 0 ? listCTOK.size() : ""%> 
                                    <td id="repsynthesis2" class="INF" align="center" style="font : bold; width : 20px 
                                        ; background-color: <%=cssGen%>; border-top-color: <%=cssleftTOP%> ; border-right-color: <%=cssleftRIG%> ;border-left-color: <%=cssleftRIG%>  ">
                                        <%=listCTKO.size() != 0 ? listCTKO.size() : ""%> 
                                    <td id="repsynthesis3" class="INF" align="center" style="font : bold ; width : 20px 
                                        ; background-color: <%=cssGen%>; border-top-color: <%=cssleftTOP%> ; border-left-color: <%=cssleftRIG%>  ">
                                        <%=listCTNE.size() != 0 ? listCTNE.size() : ""%></td>
                                        <%
                                            }
                                        %>
                                </tr>


                                <%}%>
                                <tr id="header"><td>TOTAL</td>
                                    <%

                                        for (int i = 0; i < country_list.length; i++) {
                                            List<String> listCTTOTOK = new ArrayList<String>();
                                            List<String> listCTTOTKO = new ArrayList<String>();
                                            List<String> listCTTOTNE = new ArrayList<String>();
                                            List<String> listCTTOTNT = new ArrayList<String>();

                                            for (int a = 0; a < listTOTOK.size(); a++) {
                                                String[] CTOKdetails = listTOTOK.get(a).split("-");
                                                if (country_list[i].equals(CTOKdetails[0])) {
                                                    if (CTOKdetails[1].equals("OK")) {
                                                        listCTTOTOK.add(CTOKdetails[1]);
                                                    }
                                                }
                                            }

                                            for (int a = 0; a < listTOTKO.size(); a++) {
                                                String[] CTKOdetails = listTOTKO.get(a).split("-");
                                                if (country_list[i].equals(CTKOdetails[0])) {
                                                    if (CTKOdetails[1].equals("KO")) {
                                                        listCTTOTKO.add(CTKOdetails[1]);
                                                    }
                                                }
                                            }

                                            for (int a = 0; a < listTOTNE.size(); a++) {
                                                String[] CTNEdetails = listTOTNE.get(a).split("-");
                                                if (country_list[i].equals(CTNEdetails[0])) {
                                                    if (CTNEdetails[1].equals("NE")) {
                                                        listCTTOTNE.add(CTNEdetails[1]);
                                                    }
                                                }
                                            }


                                    %>
                                    <td align="center" style="width: 20px ;color : green"><%=listCTTOTOK.size()%></td>
                                    <td align="center" style="width: 20px ;color : red"><%=listCTTOTKO.size()%></td>
                                    <td align="center" style="width: 20px ;color : #999999"><%=listCTTOTNE.size()%></td>
                                    <%                                                              }
                                    %>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <%
                            stmt.close();
                            stmt1.close();
                            stmt33.close();
                            stmt5.close();
                            stmt2.close();
                            stmt8.close();

                        }

                    } catch (Exception e) {
                        out.println(e);
                    } finally {
                        try {
                            conn.close();
                        } catch (Exception ex) {
                        }
                    }

                %>

            </form>
        </div>

        <br><% out.print(display_footer(DatePageStart));%>
    </body>
</html>