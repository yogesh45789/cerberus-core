/*
 * Cerberus  Copyright (C) 2013  vertigo17
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
package org.cerberus.servlet.testBattery;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.cerberus.factory.IFactoryTestBatteryContent;
import org.cerberus.service.ITestBatteryService;
import org.owasp.html.PolicyFactory;
import org.owasp.html.Sanitizers;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

/**
 *
 * @author memiks
 */
@WebServlet(name = "AddTestBatteryContent", urlPatterns = {"/AddTestBatteryContent"})
public class AddTestBatteryContent extends HttpServlet {

    private ITestBatteryService testBatteryService;
    private IFactoryTestBatteryContent factoryTestBatteryContent;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ApplicationContext appContext = WebApplicationContextUtils.getWebApplicationContext(this.getServletContext());
        testBatteryService = appContext.getBean(ITestBatteryService.class);
        factoryTestBatteryContent = appContext.getBean(IFactoryTestBatteryContent.class);
        PolicyFactory policy = Sanitizers.FORMATTING.and(Sanitizers.LINKS);

        String test = policy.sanitize(request.getParameter("Test"));
        String testcase = policy.sanitize(request.getParameter("TestCase"));
        String testbattery = policy.sanitize(request.getParameter("TestBattery"));

        response.setContentType("text/html");
        testBatteryService.createTestBatteryContent(factoryTestBatteryContent.create(null, test, testcase, testbattery));
    }
}
