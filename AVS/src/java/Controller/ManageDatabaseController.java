/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Entity.User;
import Model.AlgorithmModel;
import Model.HistoryModel;
import Model.NewsModel;
import Model.UserModel;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.concurrent.TimeUnit;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author Ukah
 */
@WebServlet(name = "ManageDatabase", urlPatterns = {"/manage"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 50, // 50MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class ManageDatabaseController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            UserModel userdao = new UserModel();
            HistoryModel historydao = new HistoryModel();
            //hien thi trang home neu nguoi dung khong phai admin
            Cookie cookie[] = request.getCookies();
            String roleid = "";
            String adminid = "";
            for (Cookie ck : cookie) {
                if (ck.getName().equals("roleid")) {
                    roleid = ck.getValue();
                }
                if (ck.getName().equals("userid")) {
                    adminid = ck.getValue();
//                    System.out.println("adminid: " + adminid);
                }
            }
            int adminrolenumber = 1;
            if (roleid == null || Integer.parseInt(roleid) != adminrolenumber) {
                response.sendRedirect("home");
                return;
            }
            //ket thuc kiem tra            
            String managetype = request.getParameter("managetype");
            switch (managetype) {
                case "manageaccount": {
                    String userid = request.getParameter("userid");
                    String ban = request.getParameter("ban");
                    String currenttime = java.time.LocalDate.now().toString() + " " + java.time.LocalTime.now().toString();

                    if (ban.equals("ban")) {
                        userdao.banUserID(Integer.parseInt(userid));
                        historydao.insertUserHistory(Integer.parseInt(userid), Integer.parseInt(adminid), currenttime, 1);

                    } else if (ban.equals("unban")) {
                        userdao.unbanUserID(Integer.parseInt(userid));
                        historydao.insertUserHistory(Integer.parseInt(userid), Integer.parseInt(adminid), currenttime, 0);
                    }
                    User user = userdao.getUserByUserID(userid);
                    String category = "account";
                    request.setAttribute("category", category);
                    request.setAttribute("user", user);
                    response.sendRedirect("admin?category=account");
                    break;
                }
                case "addalgo": {
                    String algoname = request.getParameter("algoname");
                    String codejava = request.getParameter("codejava");
                    String codecpp = request.getParameter("codecpp");
                    String codejs = request.getParameter("codejs");
                    String codevisual = request.getParameter("codevisual");
                    String description = request.getParameter("description");
                    String categoryid = request.getParameter("category");
                    String currenttime = java.time.LocalDate.now().toString() + " " + java.time.LocalTime.now().toString();
                    String resource = request.getParameter("resource");

                    AlgorithmModel algodao = new AlgorithmModel();
                    algodao.insertAlgo(algoname, codejava, codecpp, codejs, codevisual, description, categoryid, currenttime, resource, "null");
//                    System.out.println("add");
                    int lastalgoid = algodao.getLastRecord().getAlgoID();
                    historydao.insertAlgoHistory(Integer.parseInt(adminid), lastalgoid, currenttime, "Add");

                    response.sendRedirect("admin?category=algorithm");
                    break;
                }
                case "editalgo": {
                    String algoid = request.getParameter("algoid");
                    String algoname = request.getParameter("algoname");
                    String codejava = request.getParameter("codejava");
                    String codecpp = request.getParameter("codecpp");
                    String codejs = request.getParameter("codejs");
                    String codevisual = request.getParameter("codevisual");
                    String description = request.getParameter("description");
                    String categoryid = request.getParameter("category");
                    String currenttime = java.time.LocalDate.now().toString() + " " + java.time.LocalTime.now().toString();
                    String resource = request.getParameter("resource");

                    codejava = codejava.replaceAll("â", "&emsp;");
                    codecpp = codecpp.replaceAll("â", "&emsp;");
                    codejs = codejs.replaceAll("â", "&emsp;");
                    codevisual = codevisual.replaceAll("â", "&emsp;");

                    AlgorithmModel algodao = new AlgorithmModel();
                    algodao.updateAlgo(algoname, codejava, codecpp, codejs, codevisual, description, categoryid, currenttime, resource, Integer.parseInt(algoid));
                    historydao.insertAlgoHistory(Integer.parseInt(adminid), Integer.parseInt(algoid), currenttime, "Edit");

                    response.sendRedirect("viewalgo?id=" + algoid);
                    break;
                }
                case "deletealgo": {
                    String algoid = request.getParameter("algoid");
                    String currenttime = java.time.LocalDate.now().toString() + " " + java.time.LocalTime.now().toString();
                    System.out.println(algoid);

                    AlgorithmModel algodao = new AlgorithmModel();
                    algodao.deleteAlgo(Integer.parseInt(algoid));

                    historydao.insertAlgoHistory(Integer.parseInt(adminid), Integer.parseInt(algoid), currenttime, "Delete");
                    response.sendRedirect("admin?category=algorithm");
                    break;
                }
                case "restorealgo": {
                    String algoid = request.getParameter("algoid");
                    String currenttime = java.time.LocalDate.now().toString() + " " + java.time.LocalTime.now().toString();
                    System.out.println(algoid);

                    AlgorithmModel algodao = new AlgorithmModel();
                    algodao.restoreAlgo(Integer.parseInt(algoid));

                    historydao.insertAlgoHistory(Integer.parseInt(adminid), Integer.parseInt(algoid), currenttime, "Restore");
                    response.sendRedirect("admin?category=algorithm");
                    break;
                }
                case "addnews": {
                    String title = request.getParameter("title");
                    String content = request.getParameter("content");
                    String source = request.getParameter("source");
                    String currenttime = java.time.LocalDate.now().toString() + " " + java.time.LocalTime.now().toString();
                    String imageurl = "";
                    InputStream inputStream = null; // input stream of the upload file
                    NewsModel newsdao = new NewsModel();
                    newsdao.insertNews(title, content, currenttime, source, null, Integer.parseInt(adminid));
                    // obtains the upload file part in this multipart request
                    Part part = request.getPart("image");
                    inputStream = part.getInputStream();
                    byte[] buffer = new byte[inputStream.available()];
                    inputStream.read(buffer);
                    String filename = extractFileName(part);
                    if (!filename.isEmpty()) {
                        filename = new File(filename).getName();
                        String extentfilename = filename.substring(filename.lastIndexOf("."));
                        int newsid = newsdao.getLastRecord().getNewsID();
                        String newsimagename = "newsimage_" + newsid;
                        imageurl = getFolderUpload() + File.separator + newsimagename + extentfilename;

                        File targetFile = new File(imageurl);
                        OutputStream outStream = new FileOutputStream(targetFile);
                        outStream.write(buffer);

                        newsdao.updateNews(title, content, currenttime, source, "./images/" + newsimagename + extentfilename, Integer.parseInt(adminid), newsid);
                    
                        historydao.insertNewsHistory(Integer.parseInt(adminid), newsid, currenttime, "Add");
                    }
                    
                    

                    response.sendRedirect("admin?category=news");
                    break;
                }
                case "editnews": {
                    String newsid = request.getParameter("newsid");
                    String title = request.getParameter("title");
                    String content = request.getParameter("content");
                    String source = request.getParameter("source");
                    String currenttime = java.time.LocalDate.now().toString() + " " + java.time.LocalTime.now().toString();
                    String imageurl = request.getParameter("imageurl");
                    
                    NewsModel newsdao = new NewsModel();
                    newsdao.updateNews(title, content, currenttime, source, imageurl, Integer.parseInt(adminid), Integer.parseInt(newsid));

                    InputStream inputStream = null; // input stream of the upload file
                    Part part = request.getPart("image");
                    inputStream = part.getInputStream();
                    byte[] buffer = new byte[inputStream.available()];
                    inputStream.read(buffer);
                    String filename = extractFileName(part);
                    if (!filename.isEmpty()) {
                        filename = new File(filename).getName();
                        String extentfilename = filename.substring(filename.lastIndexOf("."));
                        String newsimagename = "newsimage_" + newsid;
                        imageurl = getFolderUpload() + File.separator + newsimagename + extentfilename;

                        File targetFile = new File(imageurl);
                        OutputStream outStream = new FileOutputStream(targetFile);
                        outStream.write(buffer);
                        TimeUnit.SECONDS.sleep(3);
                    }
                    
                    historydao.insertNewsHistory(Integer.parseInt(adminid), Integer.parseInt(newsid), currenttime, "Edit");

                    response.sendRedirect("viewnews?id=" + newsid);
                    break;
                }
                case "deletenews": {
                    String newsid = request.getParameter("newsid");
                    String currenttime = java.time.LocalDate.now().toString() + " " + java.time.LocalTime.now().toString();
                    
                    NewsModel newsdao = new NewsModel();
                    newsdao.deleteNews(Integer.parseInt(newsid));
                    
                    historydao.insertNewsHistory(Integer.parseInt(adminid), Integer.parseInt(newsid), currenttime, "Delete");
                    
                    response.sendRedirect("admin?category=news");
                    break;
                }
                case "restorenews": {
                    String newsid = request.getParameter("newsid");
                    String currenttime = java.time.LocalDate.now().toString() + " " + java.time.LocalTime.now().toString();
                    
                    NewsModel newsdao = new NewsModel();
                    newsdao.restoreNews(Integer.parseInt(newsid));
                    
                    historydao.insertNewsHistory(Integer.parseInt(adminid), Integer.parseInt(newsid), currenttime, "Restore");
                    
                    response.sendRedirect("admin?category=news");
                    break;
                }
            }

        } catch (Exception ex) {
            String currenttime = java.time.LocalDate.now().toString() + " " + java.time.LocalTime.now().toString();
            System.out.println("----Execute at " + currenttime + "----");
            System.out.println(ex);
            response.sendRedirect("error");
        }
    }

    /**
     * Extracts file name from HTTP header content-disposition
     */
    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }

    public String getFolderUpload() {
        String absolutePath = getClass().getProtectionDomain().getCodeSource().getLocation().getPath();
        //can be a bug after uploading on cloud server
        System.out.println(absolutePath + "trươc for");
        for (int i = 0; i < 5; i++) {
            absolutePath = absolutePath.substring(0, absolutePath.lastIndexOf("/"));
            System.out.println("tại i = " + i + "abso = " + absolutePath);
        }
        absolutePath = absolutePath.substring(1) + "/web/images";
        return absolutePath;
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
