/*
 * Cerberus Copyright (C) 2013 - 2017 cerberustesting
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 *
 * This file is part of Cerberus.
 *
 * Cerberus is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Cerberus is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Cerberus.  If not, see <http://www.gnu.org/licenses/>.
 */
var nbRow = 0;

$.when($.getScript("js/global/global.js")).then(function () {
    $(document).ready(function () {
        initPage();
        $('[data-toggle="popover"]').popover({
            'placement': 'auto',
            'container': 'body'}
        );
    });
});

function initPage() {
    displayPageLabel();

    // handle the click for specific action buttons
    $("#addApplicationButton").click(addEntryModalSaveHandler);
    $("#editApplicationButton").click(editEntryModalSaveHandler);

    //clear the modals fields when closed
    $('#addApplicationModal').on('hidden.bs.modal', addEntryModalCloseHandler);
    $('#editApplicationModal').on('hidden.bs.modal', editEntryModalCloseHandler);

    // Adding rows in edit Modal.
    $("#addEnvironment").click(addNewEnvironmentRow);

    // Load the select needed in localStorage cache.
    getSelectInvariant("ENVIRONMENT", true);
    getSelectInvariant("COUNTRY", true);

    $('#editApplicationModal a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
        var doc = new Doc();
        var target = $(e.target).attr("href"); // activated tab

        if (target == "#tabsEdit-3") {
            $("#editApplicationModal #applicationObjectsTable").DataTable().draw();
        }
    });


    //configure and create the dataTable
    var configurations = new TableConfigurationsServerSide("applicationsTable", "ReadApplication", "contentTable", aoColumnsFunc("applicationsTable"), [3, 'asc']);
    createDataTableWithPermissions(configurations, renderOptionsForApplication, "#applicationList", undefined, true);
}

function displayPageLabel() {
    var doc = new Doc();

    displayHeaderLabel(doc);
    $("#pageTitle").html(doc.getDocLabel("page_application", "title"));
    $("#title").html(doc.getDocOnline("page_application", "title"));
    $("#applicationListLabel").html(doc.getDocLabel("page_application", "table_application"));
    $("[name='createApplicationField']").html(doc.getDocLabel("page_application", "button_create"));
    $("[name='confirmationField']").html(doc.getDocLabel("page_application", "button_delete"));
    $("[name='editApplicationField']").html(doc.getDocLabel("page_application", "button_edit"));
    $("[name='buttonAdd']").html(doc.getDocLabel("page_global", "buttonAdd"));
    $("[name='buttonEdit']").html(doc.getDocLabel("page_global", "buttonEdit"));
    $("[name='buttonClose']").html(doc.getDocLabel("page_global", "buttonClose"));
    $("[name='buttonConfirm']").html(doc.getDocLabel("page_global", "buttonConfirm"));
    $("[name='buttonDismiss']").html(doc.getDocLabel("page_global", "buttonDismiss"));
    $("#editAppDefinition").html(doc.getDocLabel("page_global", "tab_definition"));
    $("#editAppAdvanced").html(doc.getDocLabel("page_global", "tab_advanced"));
    $("[name='applicationField']").html(doc.getDocOnline("application", "Application"));
    $("[name='descriptionField']").html(doc.getDocOnline("application", "Description"));
    //$("[name='sortField']").html(doc.getDocOnline("application", "sort"));
    $("[name='typeField']").html(doc.getDocOnline("application", "type"));
    $("[name='systemField']").html(doc.getDocOnline("application", "system"));
    $("[name='poolSizeField']").html(doc.getDocOnline("application", "poolSize"));
    $("[name='subsystemField']").html(doc.getDocOnline("application", "subsystem"));
    $("[name='svnurlField']").html(doc.getDocOnline("application", "svnurl"));
    $("[name='bugtrackerurlField']").html(doc.getDocOnline("application", "bugtrackerurl"));
    $("[name='bugtrackernewurlField']").html(doc.getDocOnline("application", "bugtrackernewurl"));
    $("[name='deploytypeField']").html(doc.getDocOnline("application", "deploytype"));
    $("[name='mavengroupidField']").html(doc.getDocOnline("application", "mavengroupid"));

    $("[name='tabsEdit1']").html(doc.getDocOnline("page_application", "tabDef"));
    $("[name='tabsEdit2']").html(doc.getDocOnline("page_application", "tabEnv"));

    $("#environmentHeader").html(doc.getDocOnline("invariant", "ENVIRONMENT"));
    $("#countryHeader").html(doc.getDocOnline("invariant", "COUNTRY"));
    $("#ipHeader").html(doc.getDocOnline("countryenvironmentparameters", "IP")
            + '<br>' + doc.getDocOnline("countryenvironmentparameters", "URLLOGIN"));
    $("#urlHeader").html(doc.getDocOnline("countryenvironmentparameters", "URL")
            + '<br>' + doc.getDocOnline("countryenvironmentparameters", "domain"));
    $("#var1Header").html(doc.getDocOnline("countryenvironmentparameters", "Var1")
            + '<br>' + doc.getDocOnline("countryenvironmentparameters", "Var2"));
    $("#var3Header").html(doc.getDocOnline("countryenvironmentparameters", "Var3")
            + '<br>' + doc.getDocOnline("countryenvironmentparameters", "Var4"));
    $("#poolSizeHeader").html(doc.getDocOnline("countryenvironmentparameters", "poolSize"));
    $("#mobileData").html(doc.getDocOnline("countryenvironmentparameters", "mobileActivity")
            + '<br>' + doc.getDocOnline("countryenvironmentparameters", "mobilePackage"));

    displayInvariantList("system", "SYSTEM", false);
    displayInvariantList("type", "APPLITYPE", false);
    displayDeployTypeList("deploytype");
    displayFooter(doc);
}

function renderOptionsForApplication(data) {
    var doc = new Doc();
    //check if user has permissions to perform the add and import operations
    if (data["hasPermissions"]) {
        if ($("#createApplicationButton").length === 0) {
            var contentToAdd = "<div class='marginBottom10'><button id='createApplicationButton' type='button' class='btn btn-default'>\n\
            <span class='glyphicon glyphicon-plus-sign'></span> " + doc.getDocLabel("page_application", "button_create") + "</button></div>";

            $("#applicationsTable_wrapper div#applicationsTable_length").before(contentToAdd);
            $('#applicationList #createApplicationButton').click(addEntryClick);
        }
    }
}

function renderOptionsForApplicationObject(id, data) {
    var doc = new Doc();
    //check if user has permissions to perform the add and import operations
    if ($("#createApplicationObjectButton").length === 0) {
        var contentToAdd = "<div class='marginBottom10'><a href='ApplicationObjectList.jsp?application=" + id + "' target='_blank'><button id='createApplicationObjectButton' type='button' class='btn btn-default'>\n\
        " + doc.getDocLabel("page_application", "button_manage") + "</button></a></div>";

        $("#applicationObjectsTable_wrapper div#applicationObjectsTable_length").before(contentToAdd);
    }
}

function deleteEntryHandlerClick() {
    var idApplication = $('#confirmationModal').find('#hiddenField1').prop("value");



    var jqxhr = $.post("DeleteApplication", {application: idApplication}, "json");
    $.when(jqxhr).then(function (data) {
        var messageType = getAlertType(data.messageType);
        if (messageType === "success") {
            //redraw the datatable
            var oTable = $("#applicationsTable").dataTable();
            oTable.fnDraw(false);
            var info = oTable.fnGetData().length;

            if (info === 1) {//page has only one row, then returns to the previous page
                oTable.fnPageChange('previous');
            }

        }
        //show message in the main page
        showMessageMainPage(messageType, data.message, false);
        //close confirmation window
        $('#confirmationModal').modal('hide');
    }).fail(handleErrorAjaxAfterTimeout);
}

function deleteEntryClick(idApplication) {
    clearResponseMessageMainPage();
    var doc = new Doc();
    var messageComplete = doc.getDocLabel("page_application", "message_delete");
    messageComplete = messageComplete.replace("%ENTRY%", idApplication);
    showModalConfirmation(deleteEntryHandlerClick, undefined, doc.getDocLabel("page_application", "button_delete"), messageComplete, idApplication, "", "", "");
}

function addEntryModalSaveHandler() {
    clearResponseMessage($('#addApplicationModal'));
    var formAdd = $("#addApplicationModal #addApplicationModalForm");

    var nameElement = formAdd.find("#application");
    var nameElementEmpty = nameElement.prop("value") === '';
    if (nameElementEmpty) {
        var localMessage = new Message("danger", "Please specify the name of the application!");
        nameElement.parents("div.form-group").addClass("has-error");
        showMessage(localMessage, $('#addApplicationModal'));
    } else {
        nameElement.parents("div.form-group").removeClass("has-error");
    }

    // verif if all mendatory fields are not empty
    if ((nameElementEmpty))
        return;

    // Get the header data from the form.
    var dataForm = convertSerialToJSONObject(formAdd.serialize());

    showLoaderInModal('#addApplicationModal');
    var jqxhr = $.post("CreateApplication", dataForm);
    $.when(jqxhr).then(function (data) {
        hideLoaderInModal('#addApplicationModal');
        if (getAlertType(data.messageType) === 'success') {
            var oTable = $("#applicationsTable").dataTable();
            oTable.fnDraw(false);
            showMessage(data);
            $('#addApplicationModal').modal('hide');
        } else {
            showMessage(data, $('#addApplicationModal'));
        }
    }).fail(handleErrorAjaxAfterTimeout);
}

function addEntryModalCloseHandler() {
    // reset form values
    $('#addApplicationModal #addApplicationModalForm')[0].reset();
    // remove all errors on the form fields
    $(this).find('div.has-error').removeClass("has-error");
    // clear the response messages of the modal
    clearResponseMessage($('#addApplicationModal'));
}

function addEntryClick() {
    clearResponseMessageMainPage();

    // When creating a new application, System takes the default value of the 
    // system already selected in header.
    var formAdd = $('#addApplicationModal');
    formAdd.find("#system").prop("value", getUser().defaultSystem);
    // Default to NONE on DeployType and Application Type.
    formAdd.find("#type").val("NONE");
    formAdd.find("#deploytype").val("NONE");

    $('#addApplicationModal').modal('show');
}

function editEntryModalSaveHandler() {
    clearResponseMessage($('#editApplicationModal'));
    var formEdit = $('#editApplicationModal #editApplicationModalForm');

    // Getting Data from Application TAB
    var table1 = $("#environmentTableBody tr");
    var table_environment = [];
    for (var i = 0; i < table1.length; i++) {
        table_environment.push($(table1[i]).data("environment"));
    }

    // Get the header data from the form.
    var data = convertSerialToJSONObject(formEdit.serialize());

    showLoaderInModal('#editApplicationModal');
    $.ajax({
        url: "UpdateApplication",
        async: true,
        method: "POST",
        data: {application: data.application,
            originalApplication: data.originalApplication,
            description: data.description,
            sort: data.sort,
            type: data.type,
            system: data.system,
            poolSize: data.poolSize,
            subsystem: data.subsystem,
            svnurl: data.svnurl,
            bugtrackerurl: data.bugtrackerurl,
            bugtrackernewurl: data.bugtrackernewurl,
            deploytype: data.deploytype,
            mavengroupid: data.mavengroupid,
            environmentList: JSON.stringify(table_environment)},
        success: function (data) {
            hideLoaderInModal('#editApplicationModal');
            if (getAlertType(data.messageType) === "success") {
                var oTable = $("#applicationsTable").dataTable();
                oTable.fnDraw(false);
                $('#editApplicationModal').modal('hide');
                showMessage(data);
            } else {
                showMessage(data, $('#editApplicationModal'));
            }
        },
        error: showUnexpectedError
    });

}

function editEntryModalCloseHandler() {
    // reset form values
    $('#editApplicationModal #editApplicationModalForm')[0].reset();
    // remove all errors on the form fields
    $(this).find('div.has-error').removeClass("has-error");
    // clear the response messages of the modal
    clearResponseMessage($('#editApplicationModal'));
}

function editEntryClick(id, system) {
    clearResponseMessageMainPage();

    // In Edit TestCase form, if we change the test, we get the latest testcase from that test.
    $('#editApplicationModalForm input[name="application"]').off("change");
    $('#editApplicationModalForm input[name="application"]').change(function () {
        // Compare with original value in order to display the warning message.
        displayWarningOnChangeApplicationKey();
    });


    var jqxhr = $.getJSON("ReadApplication", "application=" + id);
    $.when(jqxhr).then(function (data) {
        var obj = data["contentTable"];

        var formEdit = $('#editApplicationModal');

        formEdit.find("#originalApplication").prop("value", obj["application"]);
        formEdit.find("#application").prop("value", obj["application"]);
        formEdit.find("#description").prop("value", obj["description"]);
        //formEdit.find("#sort").prop("value", obj["sort"]);
        formEdit.find("#type").prop("value", obj["type"]);
        formEdit.find("#system").prop("value", obj["system"]);
        formEdit.find("#subsystem").prop("value", obj["subsystem"]);
        formEdit.find("#poolSize").prop("value", obj["poolSize"]);
        formEdit.find("#svnurl").prop("value", obj["svnurl"]);
        formEdit.find("#bugtrackerurl").prop("value", obj["bugTrackerUrl"]);
        formEdit.find("#bugtrackernewurl").prop("value", obj["bugTrackerNewUrl"]);
        formEdit.find("#deploytype").prop("value", obj["deploytype"]);
        formEdit.find("#mavengroupid").prop("value", obj["mavengroupid"]);

        if (!(data["hasPermissions"])) { // If readonly, we only readonly all fields
            formEdit.find("#application").prop("readonly", "readonly");
            formEdit.find("#description").prop("readonly", "readonly");
            //formEdit.find("#sort").prop("readonly", "readonly");
            formEdit.find("#type").prop("disabled", "disabled");
            formEdit.find("#system").prop("disabled", "disabled");
            formEdit.find("#subsystem").prop("readonly", "readonly");
            formEdit.find("#poolSize").prop("readonly", "readonly");
            formEdit.find("#svnurl").prop("readonly", "readonly");
            formEdit.find("#bugtrackerurl").prop("readonly", "readonly");
            formEdit.find("#bugtrackernewurl").prop("readonly", "readonly");
            formEdit.find("#deploytype").prop("disabled", "disabled");
            formEdit.find("#mavengroupid").prop("readonly", "readonly");

            $('#editApplicationButton').attr('class', '');
            $('#editApplicationButton').attr('hidden', 'hidden');
        }

        if ($("#editApplicationModal #applicationObjectsTable_wrapper").length > 0) {
            $("#editApplicationModal #applicationObjectsTable").DataTable().draw();
        } else {
            var configurations = new TableConfigurationsServerSide("applicationObjectsTable", "ReadApplicationObject?application=" + obj["application"], "contentTable", aoColumnsFunc_object("applicationObjectsTable"), [1, 'asc']);
            var table = createDataTableWithPermissions(configurations, function (data) {
                renderOptionsForApplicationObject(obj["application"], data);
            }, "#applicationObjectList", undefined, true);
        }

        formEdit.modal('show');
    });

    loadEnvironmentTable(system, id);
}

function loadEnvironmentTable(selectSystem, selectApplication) {
    $('#environmentTableBody tr').remove();
    var jqxhr = $.getJSON("ReadCountryEnvironmentParameters", "system=" + selectSystem + "&application=" + selectApplication + "&iSortCol_0=3");
    $.when(jqxhr).then(function (result) {
        $.each(result["contentTable"], function (idx, obj) {
            obj.toDelete = false;
            appendEnvironmentRow(obj);
        });
    }).fail(handleErrorAjaxAfterTimeout);
}

function appendEnvironmentRow(env) {
    nbRow++;
    var doc = new Doc();
    var deleteBtn = $("<button type=\"button\"></button>").addClass("btn btn-default btn-xs").append($("<span></span>").addClass("glyphicon glyphicon-trash"));
    var selectEnvironment = getSelectInvariant("ENVIRONMENT", false);
    var selectCountry = getSelectInvariant("COUNTRY", false);
    var ipInput = $("<input  maxlength=\"150\" placeholder=\"-- " + doc.getDocLabel("countryenvironmentparameters", "IP") + " --\">").addClass("form-control input-sm").val(env.ip);
    var domainInput = $("<input  maxlength=\"150\" placeholder=\"-- " + doc.getDocLabel("countryenvironmentparameters", "domain") + " --\">").addClass("form-control input-sm").val(env.domain);
    var urlInput = $("<input  maxlength=\"150\" placeholder=\"-- " + doc.getDocLabel("countryenvironmentparameters", "URL") + " --\">").addClass("form-control input-sm").val(env.url);
    var urlLoginInput = $("<input  maxlength=\"300\" placeholder=\"-- " + doc.getDocLabel("countryenvironmentparameters", "URLLOGIN") + " --\">").addClass("form-control input-sm").val(env.urlLogin);
    var var1Input = $("<input  maxlength=\"200\" placeholder=\"-- " + doc.getDocLabel("countryenvironmentparameters", "Var1") + " --\">").addClass("form-control input-sm").val(env.var1);
    var var2Input = $("<input  maxlength=\"200\" placeholder=\"-- " + doc.getDocLabel("countryenvironmentparameters", "Var2") + " --\">").addClass("form-control input-sm").val(env.var2);
    var var3Input = $("<input  maxlength=\"200\" placeholder=\"-- " + doc.getDocLabel("countryenvironmentparameters", "Var3") + " --\">").addClass("form-control input-sm").val(env.var3);
    var var4Input = $("<input  maxlength=\"200\" placeholder=\"-- " + doc.getDocLabel("countryenvironmentparameters", "Var4") + " --\">").addClass("form-control input-sm").val(env.var4);
    var poolSizeInput = $("<input  maxlength=\"150\" placeholder=\"-- " + doc.getDocLabel("countryenvironmentparameters", "poolSize") + " --\">").addClass("form-control input-sm").val(env.poolSize);
    var mobileActivity = $("<input  maxlength=\"254\" placeholder=\"-- " + doc.getDocLabel("countryenvironmentparameters", "mobileActivity") + " --\">").addClass("form-control input-sm").val(env.mobileActivity);
    var mobilePackage = $("<input  maxlength=\"254\" placeholder=\"-- " + doc.getDocLabel("countryenvironmentparameters", "mobilePackage") + " --\">").addClass("form-control input-sm").val(env.mobilePackage);

    var table = $("#environmentTableBody");

    var row = $("<tr></tr>");

    var td1 = $("<td></td>").append(deleteBtn);

    var environment = $("<div class='form-group col-sm-12'></div>").append("<label for='name'>" + doc.getDocOnline("invariant", "ENVIRONMENT") + "</label>").append(selectEnvironment.val(env.environment));
    var drow01 = $("<div class='row'></div>").append(environment);
    var country = $("<div class='form-group col-sm-12'></div>").append("<label for='name'>" + doc.getDocOnline("invariant", "COUNTRY") + "</label>").append(selectCountry.val(env.country));
    var drow02 = $("<div class='row'></div>").append(country);
    var td2 = $("<td></td>").append(drow01).append(drow02);

    var ipName = $("<div class='form-group col-sm-5'></div>").append("<label for='ip'>" + doc.getDocOnline("countryenvironmentparameters", "IP") + "</label>").append(ipInput);
    var urlName = $("<div class='form-group col-sm-3'></div>").append("<label for='url'>" + doc.getDocOnline("countryenvironmentparameters", "URL") + "</label>").append(urlInput);
    var poolSizeName = $("<div class='form-group col-sm-2'></div>").append("<label for='poolSize'>" + doc.getDocOnline("countryenvironmentparameters", "poolSize") + "</label>").append(poolSizeInput);
    var expandName = $("<div class='form-group col-sm-2'></div>").append("<button class='btn btn-primary' type='button' data-toggle='collapse' data-target='#col" + nbRow + "' aria-expanded='false' aria-controls='col" + nbRow + "'><span class='glyphicon glyphicon-chevron-down'></span></button>");
    var drow1 = $("<div class='row'></div>").append(ipName).append(urlName).append(poolSizeName).append(expandName);

    var loginName = $("<div class='form-group col-sm-6'></div>").append("<label for='login'>" + doc.getDocOnline("countryenvironmentparameters", "URLLOGIN") + "</label>").append(urlLoginInput);
    var domainName = $("<div class='form-group col-sm-6'></div>").append("<label for='domain'>" + doc.getDocOnline("countryenvironmentparameters", "domain") + "</label>").append(domainInput);
    var drow2 = $("<div class='row'></div>").append(loginName).append(domainName);

    var var1Name = $("<div class='form-group col-sm-3'></div>").append("<label for='var1'>" + doc.getDocOnline("countryenvironmentparameters", "Var1") + "</label>").append(var1Input);
    var var2Name = $("<div class='form-group col-sm-3'></div>").append("<label for='var2'>" + doc.getDocOnline("countryenvironmentparameters", "Var2") + "</label>").append(var2Input);
    var var3Name = $("<div class='form-group col-sm-3'></div>").append("<label for='var3'>" + doc.getDocOnline("countryenvironmentparameters", "Var3") + "</label>").append(var3Input);
    var var4Name = $("<div class='form-group col-sm-3'></div>").append("<label for='var4'>" + doc.getDocOnline("countryenvironmentparameters", "Var4") + "</label>").append(var4Input);
    var drow3 = $("<div class='row'></div>").append(var1Name).append(var2Name).append(var3Name).append(var4Name);

    var mobileActivityName = $("<div class='form-group col-sm-3'></div>").append("<label for='var4'>" + doc.getDocOnline("countryenvironmentparameters", "mobileActivity") + "</label>").append(mobileActivity);
    var mobilePackageName = $("<div class='form-group col-sm-3'></div>").append("<label for='var4'>" + doc.getDocOnline("countryenvironmentparameters", "mobilePackage") + "</label>").append(mobilePackage);
    var drow4 = $("<div class='row'></div>").append(mobileActivityName).append(mobilePackageName);

    var panelExtra = $("<div class='collapse' id='col" + nbRow + "'></div>").append(drow2).append(drow3).append(drow4);

    var td3 = $("<td></td>").append(drow1).append(panelExtra);

    deleteBtn.click(function () {
        env.toDelete = (env.toDelete) ? false : true;
        if (env.toDelete) {
            row.addClass("danger");
        } else {
            row.removeClass("danger");
        }
    });
    selectEnvironment.change(function () {
        env.environment = $(this).val();
    });
    selectCountry.change(function () {
        env.country = $(this).val();
    });
    ipInput.change(function () {
        env.ip = $(this).val();
    });
    domainInput.change(function () {
        env.domain = $(this).val();
    });
    urlInput.change(function () {
        env.url = $(this).val();
    });
    urlLoginInput.change(function () {
        env.urlLogin = $(this).val();
    });
    var1Input.change(function () {
        env.var1 = $(this).val();
    });
    var2Input.change(function () {
        env.var2 = $(this).val();
    });
    var3Input.change(function () {
        env.var3 = $(this).val();
    });
    var4Input.change(function () {
        env.var4 = $(this).val();
    });
    poolSizeInput.change(function () {
        env.poolSize = $(this).val();
    });
    mobileActivity.change(function () {
        env.mobileActivity = $(this).val();
    });
    mobilePackage.change(function () {
        env.mobilePackage = $(this).val();
    });
    row.append(td1);
    row.append(td2);
    row.append(td3);

    env.environment = selectEnvironment.prop("value"); // Value that has been requested by dtb parameter may not exist in combo vlaues so we take the real selected value.
    env.country = selectCountry.prop("value"); // Value that has been requested by dtb parameter may not exist in combo vlaues so we take the real selected value.
    row.data("environment", env);
    table.append(row);
}

function addNewEnvironmentRow() {
    var newEnvironment = {
        environment: "",
        country: "",
        ip: "",
        domain: "",
        url: "",
        urlLogin: "",
        var1: "",
        var2: "",
        var3: "",
        var4: "",
        poolSize: "",
        mobileActivity: "",
        mobilePackage: "",
        toDelete: false
    };
    appendEnvironmentRow(newEnvironment);
}

function displayWarningOnChangeApplicationKey() {
    // Compare with original value in order to display the warning message.
    let old1 = $("#originalApplication").val();
    let new1 = $('#editApplicationModal input[name="application"]').val();
    if (old1 !== new1) {
        var localMessage = new Message("WARNING", "If you rename that application, All the corresponding execution historic will stay on old application name.");
        showMessage(localMessage, $('#editApplicationModal'));
    } else {
        clearResponseMessage($('#editApplicationModal'));
    }
}

function aoColumnsFunc(tableId) {
    var doc = new Doc();
    var aoColumns = [
        {
            "data": null,
            "title": doc.getDocLabel("page_global", "columnAction"),
            "bSortable": false,
            "bSearchable": false,
            "sWidth": "50px",
            "mRender": function (data, type, obj) {
                var hasPermissions = $("#" + tableId).attr("hasPermissions");

                var editApplication = '<button id="editApplication" onclick="editEntryClick(\'' + obj["application"] + '\', \'' + obj["system"] + '\');"\n\
                                    class="editApplication btn btn-default btn-xs margin-right5" \n\
                                    name="editApplication" title="' + doc.getDocLabel("page_application", "button_edit") + '" type="button">\n\
                                    <span class="glyphicon glyphicon-pencil"></span></button>';
                var viewApplication = '<button id="editApplication" onclick="editEntryClick(\'' + obj["application"] + '\', \'' + obj["system"] + '\');"\n\
                                    class="editApplication btn btn-default btn-xs margin-right5" \n\
                                    name="editApplication" title="' + doc.getDocLabel("page_application", "button_edit") + '" type="button">\n\
                                    <span class="glyphicon glyphicon-eye-open"></span></button>';
                var deleteApplication = '<button id="deleteApplication" onclick="deleteEntryClick(\'' + obj["application"] + '\');" \n\
                                    class="deleteApplication btn btn-default btn-xs margin-right5" \n\
                                    name="deleteApplication" title="' + doc.getDocLabel("page_application", "button_delete") + '" type="button">\n\
                                    <span class="glyphicon glyphicon-trash"></span></button>';
                if (hasPermissions === "true") { //only draws the options if the user has the correct privileges
                    return '<div class="center btn-group width150">' + editApplication + deleteApplication + '</div>';
                }
                return '<div class="center btn-group width150">' + viewApplication + '</div>';
            }
        },
        {
            "data": "application",
            "sName": "application",
            "sWidth": "60px",
            "title": doc.getDocOnline("application", "Application")},
        {
            "data": "description",
            "like": true,
            "sName": "description",
            "sWidth": "80px",
            "title": doc.getDocOnline("application", "Description")},
        {
            "data": "sort",
            "visible": false,
            "sName": "sort",
            "sWidth": "60px",
            "title": doc.getDocOnline("application", "sort")},
        {
            "data": "type",
            "sName": "type",
            "sWidth": "60px",
            "title": doc.getDocOnline("application", "type")},
        {
            "data": "system",
            "sName": "system",
            "sWidth": "60px",
            "title": doc.getDocOnline("application", "system")},
        {
            "data": "subsystem",
            "visible": false,
            "sName": "subsystem",
            "sWidth": "60px",
            "title": doc.getDocOnline("application", "subsystem")
        },
        {
            "data": "subsystem",
            "visible": false,
            "sName": "subsystem",
            "sWidth": "60px",
            "title": doc.getDocOnline("application", "subsystem")
        },
        {
            "data": "poolSize",
            "sName": "poolSize",
            "sWidth": "80px",
            "title": doc.getDocOnline("application", "poolSize"),
        },
        {
            "data": "bugTrackerUrl",
            "visible": false,
            "like": true,
            "sName": "bugTrackerUrl",
            "sWidth": "80px",
            "title": doc.getDocOnline("application", "bugtrackerurl"),
            "mRender": function (data, type, oObj) {
                return drawURL(data);
            }
        },
        {
            "data": "bugTrackerNewUrl",
            "visible": false,
            "like": true,
            "sName": "bugTrackerNewUrl",
            "sWidth": "80px",
            "title": doc.getDocOnline("application", "bugtrackernewurl"),
            "mRender": function (data, type, oObj) {
                return drawURL(data);
            }
        },
        {
            "data": "deploytype",
            "visible": false,
            "sName": "deploytype",
            "sWidth": "60px",
            "title": doc.getDocOnline("application", "deploytype")
        },
        {
            "data": "mavengroupid",
            "visible": false,
            "sName": "mavengroupid",
            "sWidth": "60px",
            "title": doc.getDocOnline("application", "mavengroupid")
        }
    ];
    return aoColumns;
}

function aoColumnsFunc_object(tableId) {
    var doc = new Doc();
    var aoColumns = [
        {
            "data": "application",
            "sName": "application",
            "visible" : false,
            "title": doc.getDocOnline("application", "Application")
        },
        {
            "data": "object",
            "sName": "object",
            "title": doc.getDocOnline("applicationObject", "Object")
        },
        {
            "data": "value",
            "sName": "value",
            "title": doc.getDocOnline("applicationObject", "Value")
        },
        {
            "data": "screenshotFilename",
            "sName": "screenshotFilename",
            "title": doc.getDocOnline("applicationObject", "ScreenshotFileName")
        },
        {
            "data": "usrCreated",
            "sName": "usrCreated",
            "visible" : false,
            "title": doc.getDocOnline("transversal", "UsrCreated")
        },
        {
            "data": "dateCreated",
            "like": true,
            "visible" : false,
            "sName": "dateCreated",
            "title": doc.getDocOnline("transversal", "DateCreated")
        },
        {
            "data": "usrModif",
            "visible" : false,
            "sName": "usrModif",
            "title": doc.getDocOnline("transversal", "UsrModif")
        },
        {
            "data": "dateModif",
            "like": true,
            "visible" : false,
            "sName": "dateModif",
            "title": doc.getDocOnline("transversal", "DateModif")
        }
    ];
    return aoColumns;
}

function app_keyispressed(e, modalName) {
    var idname = $('#' + modalName + 'ApplicationModal #application').val();
    var toto = "|\"|'|&|";
    var charval = "|" + e.key + "|";
    if (toto.indexOf(charval) !== -1) {
        var localMessage = new Message("WARNING", "Character '" + e.key + "' is not allowed for application names.");
        showMessage(localMessage, $('#' + modalName + 'ApplicationModal'), false, 1000);
        return false;
    }
    return true;
}

