/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DBContext.DBContext;
import Model.Algorithm;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Jisoo
 */
public class AlgorithmDAO {

    private final DBContext db;

    public AlgorithmDAO() throws Exception {
        db = new DBContext();
    }
    //new function cua quang

    public ArrayList<Algorithm> getAlgosortbyID(int categoryID) throws SQLException, Exception {
        ArrayList<Algorithm> listAllAlgorithms = new ArrayList<>();
        DBContext dbManager = new DBContext();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        try {
            connection = dbManager.getConnection();
            String sql = "SELECT algo_ID algoid,algo_Name algoname  FROM Algorithm \n"
                    + "WHERE algo_CompareStatus = 1 AND category_ID = ? ORDER BY algo_ID";
            statement = connection.prepareStatement(sql);
            statement.setInt(1, categoryID);
            rs = statement.executeQuery();
            while (rs.next()) {
                int algoid = rs.getInt("algoid");
                String algoname = rs.getString("algoname");
                int number_of_step = 0;
                listAllAlgorithms.add(new Algorithm(algoid, algoname, "", "", "", "", 0, "", "", number_of_step));
            }
        } catch (Exception e) {
            throw e;
        } finally {
            new CloseConnection().close(connection, statement, rs);
        }
        return listAllAlgorithms;
    }

    public ArrayList<Algorithm> getAlgoNameAndCategory() throws SQLException, Exception {
        ArrayList<Algorithm> listAllAlgorithms = new ArrayList<>();
        DBContext dbManager = new DBContext();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        try {
            connection = dbManager.getConnection();
            String sql = "SELECT [algo_ID],[algo_Name],[algo_CodeJS],Algorithm.category_ID,[category_Name] \n"
                    + "FROM Algorithm INNER JOIN Category ON Category.category_ID = Algorithm.category_ID \n"
                    + "Where delete_Status=0\n"
                    + "ORDER BY Algorithm.category_ID";

            statement = connection.prepareStatement(sql);
            rs = statement.executeQuery();
            while (rs.next()) {
                Algorithm algorithm = new Algorithm();
                algorithm.setAlgoID(rs.getInt("algo_ID"));
                algorithm.setAlgoName(rs.getString("algo_Name"));
                algorithm.setCategoryID(rs.getInt("category_ID"));
                algorithm.setCategoryName(rs.getString("category_Name"));
                listAllAlgorithms.add(algorithm);
            }
        } catch (Exception e) {
            throw e;
        } finally {
            new CloseConnection().close(connection, statement, rs);
        }
        return listAllAlgorithms;
    }

    public ArrayList<Algorithm> getAlgoIDList() throws SQLException, Exception {
        ArrayList<Algorithm> algos = new ArrayList<>();
        DBContext dbManager = new DBContext();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        try {
            connection = dbManager.getConnection();
            statement = connection.prepareStatement("Select algo_ID from Algorithm");
            rs = statement.executeQuery();
            while (rs.next()) {
                Algorithm algo = new Algorithm();
                algo.setAlgoID(rs.getInt("algo_ID"));
                algos.add(algo);
            }
        } catch (Exception e) {
            throw e;
        } finally {
            new CloseConnection().close(connection, statement, rs);
        }
        return algos;
    }

    public Algorithm getAlgoByID(int ID) throws SQLException, Exception {
        DBContext dbManager = new DBContext();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        try {
            connection = dbManager.getConnection();
            statement
                    = connection.prepareStatement("SELECT * from Algorithm where algo_ID = ?;");
            statement.setInt(1, ID);
            rs = statement.executeQuery();
            if (rs.next()) {
                Algorithm algo = new Algorithm();
                algo.setAlgoID(rs.getInt("algo_ID"));
                algo.setAlgoName(rs.getString("algo_Name"));
                algo.setAlgoCodeJS(rs.getString("algo_CodeJS"));
                algo.setAlgoCodeCplus(rs.getString("algo_CodeCplus"));
                algo.setAlgoCodeJava(rs.getString("algo_CodeJava"));
                algo.setAlgoDescription(rs.getString("algo_Description"));
                algo.setCategoryID(rs.getInt("category_ID"));
                algo.setAlgoDatetime(rs.getString("algo_datetime"));
                algo.setAlgoResource(rs.getString("algo_Resource"));
                algo.setAlgoFile(rs.getString("algo_Files"));
                algo.setDeleted(rs.getInt("delete_status"));
                return algo;
            }
        } catch (Exception e) {
            throw e;
        } finally {
            new CloseConnection().close(connection, statement, rs);
        }

        return null;
    }

    public ArrayList<Algorithm> getAlgoByCategory(int categoryID) throws SQLException, Exception {
        ArrayList<Algorithm> algos = new ArrayList<Algorithm>();
        DBContext dbManager = new DBContext();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        try {
            connection = dbManager.getConnection();
            statement
                    = connection.prepareStatement("SELECT * from Algorithm "
                            + "WHERE category_ID = ? AND algo_CompareStatus = 1 "
                            + "ORDER BY algo_ID;");
            statement.setInt(1, categoryID);
            rs = statement.executeQuery();
            while (rs.next()) {
                Algorithm algo = new Algorithm();
                algo.setAlgoID(rs.getInt("algo_ID"));
                algo.setAlgoName(rs.getString("algo_Name"));
                algo.setCategoryID(rs.getInt("category_ID"));
                algos.add(algo);
            }
        } catch (Exception e) {
            throw e;
        } finally {
            new CloseConnection().close(connection, statement, rs);
        }
        return algos;
    }

    public ArrayList<Algorithm> getAllAlgo() throws SQLException, Exception {
        ArrayList<Algorithm> algos = new ArrayList();
        DBContext dbManager = new DBContext();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        try {
            connection = dbManager.getConnection();
            statement
                    = connection.prepareStatement("SELECT * from Algorithm "
                            + "ORDER BY algo_ID;");
            rs = statement.executeQuery();
            while (rs.next()) {
                Algorithm algo = new Algorithm();
                algo.setAlgoID(rs.getInt("algo_ID"));
                algo.setAlgoName(rs.getString("algo_Name"));
                algo.setCategoryID(rs.getInt("category_ID"));
                algo.setVisualized(rs.getInt("algo_CompareStatus"));
                algos.add(algo);
            }
        } catch (Exception e) {
            throw e;
        } finally {
            new CloseConnection().close(connection, statement, rs);
        }
        return algos;
    }

    public ArrayList<Algorithm> getAllAlgoButDeleted() throws SQLException, Exception {
        ArrayList<Algorithm> algos = new ArrayList();
        DBContext dbManager = new DBContext();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        try {
            connection = dbManager.getConnection();
            statement
                    = connection.prepareStatement("SELECT * from Algorithm\n"
                            + "WHERE delete_status = 0\n"
                            + "ORDER BY algo_ID");
            rs = statement.executeQuery();
            while (rs.next()) {
                Algorithm algo = new Algorithm();
                algo.setAlgoID(rs.getInt("algo_ID"));
                algo.setAlgoName(rs.getString("algo_Name"));
                algo.setCategoryID(rs.getInt("category_ID"));
                algo.setVisualized(rs.getInt("algo_CompareStatus"));
                algos.add(algo);
            }
        } catch (Exception e) {
            throw e;
        } finally {
            new CloseConnection().close(connection, statement, rs);
        }
        return algos;
    }

    public void insertAlgo(Algorithm algo) throws Exception {
        String currenttime = java.time.LocalDate.now(ZoneId.of("Asia/Bangkok")).toString() + " " 
                    + java.time.LocalTime.now(ZoneId.of("Asia/Bangkok")).toString();
        String query = "Insert into [Algorithm] (algo_Name, algo_CodeJava, algo_CodeCplus, algo_CodeJS, algo_Description, \n"
                + "category_ID, algo_DateTime, algo_Resource, algo_Files, algo_CompareStatus, delete_Status)\n"
                + "values (?, ?, ?, ?, ?, ?, ?, ?, 'null', 0, 0)";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = db.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, algo.getAlgoName());
            ps.setString(2, algo.getAlgoCodeJava());
            ps.setString(3, algo.getAlgoCodeCplus());
            ps.setString(4, algo.getAlgoCodeJS());
            ps.setString(5, algo.getAlgoDescription());
            ps.setInt(6, algo.getCategoryID());
            ps.setString(7, currenttime);
            ps.setString(8, algo.getAlgoResource());
            ps.executeQuery();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Algorithm getLastRecord() throws SQLException, Exception {
        DBContext dbManager = new DBContext();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        try {
            connection = dbManager.getConnection();
            statement
                    = connection.prepareStatement("SELECT TOP 1 * FROM [Algorithm] ORDER BY [algo_ID] DESC");
            rs = statement.executeQuery();
            if (rs.next()) {
                Algorithm algo = new Algorithm();
                algo.setAlgoID(rs.getInt("algo_ID"));
                algo.setAlgoName(rs.getString("algo_Name"));
                algo.setCategoryID(rs.getInt("category_ID"));
                algo.setVisualized(rs.getInt("algo_CompareStatus"));
                return algo;
            }
        } catch (Exception e) {
            throw e;
        } finally {
            new CloseConnection().close(connection, statement, rs);
        }
        return null;
    }

    public void deleteAlgo(int algoid) throws Exception {
        String query = "update [Algorithm]\n"
                + "set delete_Status = 1\n"
                + "where algo_id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = db.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, algoid);
            ps.executeQuery();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void restoreAlgo(int algoid) throws Exception {
        String query = "update [Algorithm]\n"
                + "set delete_Status = 0\n"
                + "where algo_id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = db.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, algoid);
            ps.executeQuery();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateAlgo(Algorithm algo) throws Exception {
        String query = "update Algorithm\n"
                + "set algo_Name=?, algo_CodeJava=?,algo_CodeCplus=?,algo_CodeJS=?,\n"
                + "algo_Description=?,category_ID=?,algo_DateTime=?,algo_Resource=?\n"
                + "where algo_ID = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = db.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, algo.getAlgoName());
            ps.setString(2, algo.getAlgoCodeJava());
            ps.setString(3, algo.getAlgoCodeCplus());
            ps.setString(4, algo.getAlgoCodeJS());
            ps.setString(5, algo.getAlgoDescription());
            ps.setInt(6, algo.getCategoryID());
            ps.setString(7, algo.getAlgoDatetime());
            ps.setString(8, algo.getAlgoResource());
            ps.setInt(9, algo.getAlgoID());
            ps.executeQuery();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int getAllSearchAlgo(String searchstring, String deleted) throws SQLException, Exception {
        DBContext dbManager = new DBContext();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        try {
            connection = dbManager.getConnection();
            String statementstring = "SELECT COUNT(*) as totalpage\n"
                    + "FROM (select *, ROW_NUMBER() over(order by algo_id) as rownumber from Algorithm) as n\n"
                    + "WHERE algo_Name like ? ";
            if (!"showdeleted".equals(deleted)) {
                statementstring += "and delete_Status = 0\n";
            }
//            System.out.println(statementstring);

            statement
                    = connection.prepareStatement(statementstring);
            statement.setString(1, '%' + searchstring + '%');
            rs = statement.executeQuery();
            if (rs.next()) {
                return (rs.getInt("totalpage"));
            }
        } catch (Exception e) {
            throw e;
        } finally {
            new CloseConnection().close(connection, statement, rs);
        }
        return 0;
    }

    public ArrayList<Algorithm> getPagingSearchAlgo(String searchstring, String deleted, String columnname, String sortorder, int start, int end) throws SQLException, Exception {
        ArrayList<Algorithm> algos = new ArrayList();
        DBContext dbManager = new DBContext();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        try {
            connection = dbManager.getConnection();
            String statementstring = "SELECT n.*\n"
                    + "FROM (select a.*,c.category_Name, ROW_NUMBER() over(order by algo_id) as rownumber from Algorithm as a \n"
                    + "inner join Category as c	on a.category_ID = c.category_ID ";
            if (!"showdeleted".equals(deleted)) {
                statementstring += "where delete_Status = 0";
            }
            statementstring += ") as n\n"
                    + "WHERE  n.rownumber >= ? and n.rownumber <= ? and algo_Name like ? ";
            statementstring += "ORDER BY " + columnname + " " + sortorder;

            statement
                    = connection.prepareStatement(statementstring);
            statement.setInt(1, start);
            statement.setInt(2, end);
            statement.setString(3, '%' + searchstring + '%');
            rs = statement.executeQuery();
            while (rs.next()) {
                Algorithm algo = new Algorithm();
                algo.setAlgoID(rs.getInt("algo_ID"));
                algo.setAlgoName(rs.getString("algo_Name"));
                algo.setCategoryID(rs.getInt("category_ID"));
                algo.setVisualized(rs.getInt("algo_CompareStatus"));
                algo.setCategoryName(rs.getString("category_Name"));
                algo.setAlgoFile(rs.getString("algo_Files"));
                algo.setDeleted(rs.getInt("delete_Status"));
                algos.add(algo);
            }
        } catch (Exception e) {
            throw e;
        } finally {
            new CloseConnection().close(connection, statement, rs);
        }
        return algos;
    }

    public Algorithm getAlgoByName(String name) throws SQLException, Exception {
        DBContext dbManager = new DBContext();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        try {
            connection = dbManager.getConnection();
            statement
                    = connection.prepareStatement("SELECT * from Algorithm where algo_Name = ?;");
            statement.setString(1, name);
            rs = statement.executeQuery();
            if (rs.next()) {
                Algorithm algo = new Algorithm();
                return algo;
            }
        } catch (Exception e) {
            throw e;
        } finally {
            new CloseConnection().close(connection, statement, rs);
        }

        return null;
    }
}
