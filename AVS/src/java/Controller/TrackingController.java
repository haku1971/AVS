/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.TrackingModel;
import Model.Tracking;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigInteger;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Asus
 */
@WebServlet(name = "TrackingController", urlPatterns = {"/TrackingController"})
public class TrackingController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int algoid = Integer.parseInt(request.getParameter("algoid"));
            String ipuser = null;
            String dateaccess = request.getParameter("dateaccess");
            String totaltime = request.getParameter("totaltime");
            BigInteger timeCount = new BigInteger(totaltime);
            TrackingModel trackingModel = new TrackingModel();
            if (request.getParameter("ipuser") != null) {
                ipuser = request.getParameter("ipuser");
                Tracking trackingUser = trackingModel.getUserAccess(ipuser, algoid, dateaccess);
                if (trackingUser != null) {
                    timeCount = timeCount.add(trackingUser.getTotalTime());
                    trackingModel.updateTracking(ipuser, algoid, dateaccess, timeCount);
                } else {
                    trackingModel.saveTracking(ipuser, algoid, dateaccess, timeCount);
                }
            } else {
                System.out.println("nullllllll");
            }

            System.out.println("algoid " + algoid + " ipuser: " + ipuser + " time:" + dateaccess + "totaltime" + timeCount);
        } catch (Exception ex) {
            System.out.println(ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
