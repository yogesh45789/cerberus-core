/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.redcats.tst.servlet.environment;

import com.redcats.tst.database.DatabaseSpring;
import com.redcats.tst.log.MyLogger;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import version.Version;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * @author vertigo
 */
@WebServlet(name = "UpdateCountryEnv", urlPatterns = {"/UpdateCountryEnv"})
public class UpdateCountryEnv extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        ApplicationContext appContext = WebApplicationContextUtils.getWebApplicationContext(this.getServletContext());
        DatabaseSpring database = appContext.getBean(DatabaseSpring.class);

        Connection connection = database.connect();
        try {
            String country = "";
            if (request.getParameter("country") != null && request.getParameter("country").compareTo("") != 0) {
                country = request.getParameter("country");
            }
            String env = "";
            if (request.getParameter("env") != null && request.getParameter("env").compareTo("") != 0) {
                env = request.getParameter("env");
            }
            String type = "";
            if (request.getParameter("type") != null && request.getParameter("type").compareTo("") != 0) {
                type = request.getParameter("type");
            }
            String distriblist = "";
            if (request.getParameter("distriblist") != null && request.getParameter("distriblist").compareTo("") != 0) {
                distriblist = request.getParameter("distriblist");
            }
            String bodydisenv = "";
            if (request.getParameter("bodydisenv") != null && request.getParameter("bodydisenv").compareTo("") != 0) {
                bodydisenv = request.getParameter("bodydisenv");
            }
            String bodyrev = "";
            if (request.getParameter("bodyrev") != null && request.getParameter("bodyrev").compareTo("") != 0) {
                bodyrev = request.getParameter("bodyrev");
            }
            String bodychain = "";
            if (request.getParameter("bodychain") != null && request.getParameter("bodychain").compareTo("") != 0) {
                bodychain = request.getParameter("bodychain");
            }


            Statement stmt = connection.createStatement();

            try {
                String req_update_active = "UPDATE countryenvparam "
                        + " SET DistribList='" + distriblist + "' , EMailBodyRevision='" + bodyrev + "'"
                        + ", EMailBodyChain='" + bodychain + "', EMailBodyDisableEnvironment='" + bodydisenv + "' "
                        + ", type='" + type + "'"
                        + "WHERE Country='" + country + "' and Environment='" + env + "'";
                stmt.executeUpdate(req_update_active);
            } finally {
                stmt.close();
            }

            response.sendRedirect("Environment.jsp?country=" + country + "&env=" + env);

        } catch (Exception e) {
            Logger.getLogger(UpdateCountryEnv.class.getName()).log(Level.SEVERE, Version.PROJECT_NAME_VERSION + " - Exception catched.", e);
            out.println(e.getMessage());
        } finally {
            out.close();
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                MyLogger.log(UpdateCountryEnv.class.getName(), org.apache.log4j.Level.WARN, e.toString());
            }
        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
