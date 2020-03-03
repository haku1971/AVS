/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import DBContext.DBContext;
import Entity.Algorithm;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Jisoo
 */
public class AlgorithmModel {

    private final DBContext db;

    public AlgorithmModel() throws Exception {
        db = new DBContext();
    }
    //new function cua quang

    public ArrayList<Algorithm> getAlgosortbyID() throws SQLException, Exception {
        ArrayList<Algorithm> listAllAlgorithms = new ArrayList<>();
        DBContext dbManager = new DBContext();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        try {
            connection = dbManager.getConnection();
            String sql = "SELECT * FROM Algorithm ORDER BY algo_ID asc";
            statement = connection.prepareStatement(sql);
            rs = statement.executeQuery();
            while (rs.next()) {
                int algoid = rs.getInt(1);
                String algoname = rs.getString(2);
                String algocodejava = rs.getString(3);
                String algocodecplus = rs.getString(4);
                String algocodejs = rs.getString(5);
                String algodescription = rs.getString(6);
                int categoryid = rs.getInt(7);
                String algodatetime = rs.getString(9);
                String algoresource = rs.getString(9);
                int number_of_step= 0;
                listAllAlgorithms.add(new Algorithm(algoid, algoname, algocodejava, algocodecplus, algocodejs, algodescription, categoryid, algodatetime, algoresource,number_of_step));
            }
        } catch (Exception e) {
            throw e;
        } finally {
            new CloseConnection().close(connection, statement, rs);
        }
        return listAllAlgorithms;
    }

    public ArrayList<Algorithm> getSortAlgo() throws SQLException, Exception {
        ArrayList<Algorithm> listAllAlgorithms = new ArrayList<>();
        DBContext dbManager = new DBContext();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        try {
            connection = dbManager.getConnection();
            String sql = "SELECT * FROM Algorithm where category_id=2";
            statement = connection.prepareStatement(sql);
            rs = statement.executeQuery();
            while (rs.next()) {
                int algoid = rs.getInt(1);
                String algoname = rs.getString(2);
                String algocodejava = rs.getString(3);
                String algocodecplus = rs.getString(4);
                String algocodejs = rs.getString(5);
                String algodescription = rs.getString(6);
                int categoryid = rs.getInt(7);
                String algodatetime = rs.getString(9);
                String algoresource = rs.getString(9);
                listAllAlgorithms.add(new Algorithm(algoid, algoname, algocodejava, algocodecplus, algocodejs, algodescription, categoryid, algodatetime, algoresource));
            }
        } catch (Exception e) {
            throw e;
        } finally {
            new CloseConnection().close(connection, statement, rs);
        }
        return listAllAlgorithms;
    }

    public ArrayList<Algorithm> getSearchAlgo() throws SQLException, Exception {
        ArrayList<Algorithm> listAllAlgorithms = new ArrayList<>();
        DBContext dbManager = new DBContext();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        try {
            connection = dbManager.getConnection();
            String sql = "SELECT * FROM Algorithm where category_id=1";
            statement = connection.prepareStatement(sql);
            rs = statement.executeQuery();
            while (rs.next()) {
                int algoid = rs.getInt(1);
                String algoname = rs.getString(2);
                String algocodejava = rs.getString(3);
                String algocodecplus = rs.getString(4);
                String algocodejs = rs.getString(5);
                String algodescription = rs.getString(6);
                int categoryid = rs.getInt(7);
                String algodatetime = rs.getString(8);
                String algoresource = rs.getString(9);

                listAllAlgorithms.add(new Algorithm(algoid, algoname, algocodejava, algocodecplus, algocodejs, algodescription, categoryid, algodatetime, algoresource));
            }
        } catch (Exception e) {
            throw e;
        } finally {
            new CloseConnection().close(connection, statement, rs);
        }
        return listAllAlgorithms;
    }
}
