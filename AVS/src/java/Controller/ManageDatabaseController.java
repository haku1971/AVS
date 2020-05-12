/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.Algorithm;
import Model.News;
import Model.User;
import DAO.AlgorithmDAO;
import DAO.CategoryDAO;
import DAO.HistoryDAO;
import DAO.NewsDAO;
import DAO.UserDAO;
import Model.Category;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.time.ZoneId;
import java.util.ArrayList;
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
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        try {

            UserDAO userdao = new UserDAO();
            HistoryDAO historydao = new HistoryDAO();
            //hien thi trang home neu nguoi dung khong phai admin
            Cookie cookie[] = request.getCookies();
            String roleid = "";
            String adminid = "";
            String username = "";
            for (Cookie ck : cookie) {
                if (ck.getName().equals("roleid")) {
                    roleid = ck.getValue();
                }
                if (ck.getName().equals("userid")) {
                    adminid = ck.getValue();
//                    System.out.println("adminid: " + adminid);
                }
                if (ck.getName().equals("username")) {
                    username = ck.getValue();
                }
            }
            int adminrolenumber = 1;
            if (roleid == null || roleid.equals("") || Integer.parseInt(roleid) != adminrolenumber) {
                response.sendRedirect("home");
                return;
            }
            //ket thuc kiem tra            
            String managetype = request.getParameter("managetype");
            switch (managetype) {
                case "manageaccount": {
                    String userid = request.getParameter("userid");
                    String ban = request.getParameter("ban");
                    String currenttime = java.time.LocalDate.now(ZoneId.of("Asia/Bangkok")).toString() + " " + java.time.LocalTime.now(ZoneId.of("Asia/Bangkok")).toString();

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
                    response.sendRedirect("viewaccount?id=" + userid);
                    break;
                }
                case "addalgo": {
                    String algoname = request.getParameter("algoname").trim();
                    String codejava = request.getParameter("codejava").trim();
                    String codecpp = request.getParameter("codecpp").trim();
                    String codejs = request.getParameter("codejs").trim();
                    String description = request.getParameter("description").trim();
                    String categoryid = request.getParameter("category").trim();
                    String currenttime = java.time.LocalDate.now(ZoneId.of("Asia/Bangkok")) + " " + java.time.LocalTime.now(ZoneId.of("Asia/Bangkok")).toString();
                    String resource = request.getParameter("resource").trim();

                    AlgorithmDAO algodao = new AlgorithmDAO();
                    if (algodao.getAlgoByName(algoname) != null) {
                        CategoryDAO catedao = new CategoryDAO();
                        ArrayList<Category> listcate = catedao.getAllCategory();

                        String category = "algorithm";
                        String errormessage = "Save fail: Algorithm name has exist!";
                        request.setAttribute("category", category);
                        request.setAttribute("addnew", true);
                        request.setAttribute("listalgocategory", listcate);
                        request.setAttribute("errormessage", errormessage);
                        request.getRequestDispatcher("view/viewalgo.jsp").forward(request, response);
                    } else {

                        Algorithm algo = new Algorithm();
                        algo.setAlgoName(algoname);
                        algo.setAlgoCodeJava(codejava);
                        algo.setAlgoCodeCplus(codecpp);
                        algo.setAlgoCodeJS(codejs);
                        algo.setAlgoDescription(description);
                        algo.setCategoryID(Integer.parseInt(categoryid));
                        algo.setAlgoResource(resource);
                        algodao.insertAlgo(algo);

//                    algodao.insertAlgo(algoname, codejava, codecpp, codejs, codevisual, description, categoryid, currenttime, resource, "null");
                        int lastalgoid = algodao.getLastRecord().getAlgoID();
                        historydao.insertAlgoHistory(Integer.parseInt(adminid), lastalgoid, currenttime, "Add");

                        response.sendRedirect("admin?category=algorithm");
                    }
                    break;
                }
                case "editalgo": {
                    String algoid = request.getParameter("algoid").trim();
                    String algoname = request.getParameter("algoname").trim();
                    String codejava = request.getParameter("codejava").trim();
                    String codecpp = request.getParameter("codecpp").trim();
                    String codejs = request.getParameter("codejs").trim();
                    String description = request.getParameter("description").trim();
                    String categoryid = request.getParameter("category").trim();
                    String currenttime = java.time.LocalDate.now(ZoneId.of("Asia/Bangkok")).toString() + " " + java.time.LocalTime.now(ZoneId.of("Asia/Bangkok")).toString().trim();
                    String resource = request.getParameter("resource").trim();

                    codejava = codejava.replaceAll("â", "&emsp;");
                    codecpp = codecpp.replaceAll("â", "&emsp;");
                    codejs = codejs.replaceAll("â", "&emsp;");

                    AlgorithmDAO algodao = new AlgorithmDAO();
                    Algorithm algo = new Algorithm();
                    algo.setAlgoID(Integer.parseInt(algoid));
                    algo.setAlgoName(algoname);
                    algo.setAlgoCodeJava(codejava);
                    algo.setAlgoCodeCplus(codecpp);
                    algo.setAlgoCodeJS(codejs);
                    algo.setAlgoDescription(description);
                    algo.setCategoryID(Integer.parseInt(categoryid));
                    algo.setAlgoResource(resource);

                    algodao.updateAlgo(algo);
//                    algodao.updateAlgo(algoname, codejava, codecpp, codejs, codevisual, description, categoryid, currenttime, resource, Integer.parseInt(algoid));
                    historydao.insertAlgoHistory(Integer.parseInt(adminid), Integer.parseInt(algoid), currenttime, "Edit");

                    response.sendRedirect("viewalgo?id=" + algoid);
                    break;
                }
                case "deletealgo": {
                    String algoid = request.getParameter("algoid");
                    String currenttime = java.time.LocalDate.now(ZoneId.of("Asia/Bangkok")).toString() + " " + java.time.LocalTime.now(ZoneId.of("Asia/Bangkok")).toString();
                    System.out.println(algoid);

                    AlgorithmDAO algodao = new AlgorithmDAO();
                    algodao.deleteAlgo(Integer.parseInt(algoid));

                    historydao.insertAlgoHistory(Integer.parseInt(adminid), Integer.parseInt(algoid), currenttime, "Delete");
                    response.sendRedirect("admin?category=algorithm");
                    break;
                }
                case "restorealgo": {
                    String algoid = request.getParameter("algoid");
                    String currenttime = java.time.LocalDate.now(ZoneId.of("Asia/Bangkok")).toString() + " " + java.time.LocalTime.now(ZoneId.of("Asia/Bangkok")).toString();
                    System.out.println(algoid);

                    AlgorithmDAO algodao = new AlgorithmDAO();
                    algodao.restoreAlgo(Integer.parseInt(algoid));

                    historydao.insertAlgoHistory(Integer.parseInt(adminid), Integer.parseInt(algoid), currenttime, "Restore");
                    response.sendRedirect("viewalgo?id=" + algoid);
                    break;
                }
                case "addnews": {

                    String title = request.getParameter("title").trim();
                    String content = request.getParameter("content").trim();
                    String source = request.getParameter("source").trim();
                    String currenttime = java.time.LocalDate.now(ZoneId.of("Asia/Bangkok")).toString() + " " + java.time.LocalTime.now(ZoneId.of("Asia/Bangkok")).toString();
                    String imageurl = "";
                    InputStream inputStream = null; // input stream of the upload file

                    NewsDAO newsdao = new NewsDAO();
                    News news = new News();
                    news.setNewstittles(title);
                    news.setNewscontent(content);
                    news.setNewsresource(source);
                    User user = new User();
                    user.setId(Integer.parseInt(adminid));
                    news.setUser(user);
                    newsdao.insertNews(news);
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

                        news.setNewsID(newsid);
                        news.setNews_Imgs("./images/" + newsimagename + extentfilename);
                        newsdao.updateNews(news);

                        historydao.insertNewsHistory(Integer.parseInt(adminid), newsid, currenttime, "Add");
                    }

                    response.sendRedirect("admin?category=news");
                    break;
                }
                case "editnews": {
                    String userid = request.getParameter("userid");
                    String newsid = request.getParameter("newsid");
                    String title = request.getParameter("title").trim();
                    String content = request.getParameter("content").trim();
                    String source = request.getParameter("source").trim();
                    String currenttime = request.getParameter("createtime").trim();
                    String imageurl = request.getParameter("imageurl").trim();

                    NewsDAO newsdao = new NewsDAO();
                    News news = new News();
                    news.setNewsID(Integer.parseInt(newsid));
                    news.setNewstittles(title);
                    news.setNewscontent(content);
                    news.setNewsresource(source);
                    User user = new User();
                    user.setId(Integer.parseInt(userid));
                    news.setUser(user);

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
                        System.out.println("imageurl = " + imageurl);
                        File targetFile = new File(imageurl);
                        OutputStream outStream = new FileOutputStream(targetFile);
                        outStream.write(buffer);
                        TimeUnit.SECONDS.sleep(3);
                        news.setNews_Imgs("./images/" + newsimagename + extentfilename);
                    } else {
                        news.setNews_Imgs(imageurl);
                    }

                    newsdao.updateNews(news);

                    historydao.insertNewsHistory(Integer.parseInt(adminid), Integer.parseInt(newsid), currenttime, "Edit");

                    response.sendRedirect("viewnews?id=" + newsid);
                    break;
                }
                case "deletenews": {
                    String newsid = request.getParameter("newsid");
                    String currenttime = java.time.LocalDate.now(ZoneId.of("Asia/Bangkok")).toString() + " " + java.time.LocalTime.now(ZoneId.of("Asia/Bangkok")).toString();

                    NewsDAO newsdao = new NewsDAO();
                    newsdao.deleteNews(Integer.parseInt(newsid));

                    historydao.insertNewsHistory(Integer.parseInt(adminid), Integer.parseInt(newsid), currenttime, "Delete");

                    response.sendRedirect("admin?category=news");
                    break;
                }
                case "restorenews": {
                    String newsid = request.getParameter("newsid");
                    String currenttime = java.time.LocalDate.now(ZoneId.of("Asia/Bangkok")).toString() + " " + java.time.LocalTime.now(ZoneId.of("Asia/Bangkok")).toString();

                    NewsDAO newsdao = new NewsDAO();
                    newsdao.restoreNews(Integer.parseInt(newsid));

                    historydao.insertNewsHistory(Integer.parseInt(adminid), Integer.parseInt(newsid), currenttime, "Restore");

                    response.sendRedirect("viewnews?id=" + newsid);
                    break;
                }
            }

        } catch (Exception ex) {
            String currenttime = java.time.LocalDate.now(ZoneId.of("Asia/Bangkok")).toString() + " " + java.time.LocalTime.now(ZoneId.of("Asia/Bangkok")).toString();
            System.out.println("----Execute at " + currenttime + "----");
            System.out.println(ex);
            response.sendRedirect("error?error=" + ex);
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
        absolutePath = absolutePath.substring(0, absolutePath.lastIndexOf("AVS") + 3);
        //local
//        absolutePath += "/web/images";
        //server
        absolutePath += "/images";
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
