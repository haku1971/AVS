/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DBContext.DBContext;
import Model.Category;
import Model.History;
import Model.News;
import Model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Jisoo
 */
public class CategoryModel {
    private final DBContext db;

    public CategoryModel() throws Exception {
        db = new DBContext();
    }
    
    public ArrayList<Category> getAllCategory() throws SQLException, Exception {
        ArrayList<Category> listcate = new ArrayList();
        DBContext dbManager = new DBContext();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        try {
            connection = dbManager.getConnection();
            String sql = "SELECT * FROM Category";
            statement = connection.prepareStatement(sql);
            rs = statement.executeQuery();
            while (rs.next()) {
                Category category = new Category();
                category.setCategoryID(rs.getInt("category_ID"));
                category.setCategoryName(rs.getString("category_Name"));
                listcate.add(category);
            }
        } catch (Exception e) {
            throw e;
        } finally {
            new CloseConnection().close(connection, statement, rs);
        }
        return listcate;
    }
}
