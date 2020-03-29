/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import DBContext.DBContext;
import Entity.Jobs;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author BinhNT
 */
public class JobsModel {
    private final DBContext db;

    public JobsModel()throws Exception{
        db = new DBContext();
    }
    public Jobs getJobByID(int jobid) throws Exception {
        String query = "select * from Jobs where job_ID=?";
        Connection conn = null;
        PreparedStatement ps = null; //de nhan paramenter
        ResultSet rs = null;
        try {
            conn = db.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, jobid);
            rs = ps.executeQuery();

            if (rs.next()) {
                Jobs job = new Jobs();
                job.setJobid(rs.getInt("job_ID"));
                job.setJobname(rs.getString("job_Name"));
                
                return job;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }
    public ArrayList<Jobs> getJobs() throws Exception {
        String query = "select * from Jobs";
        ArrayList<Jobs> jobs = new ArrayList<>();
        DBContext dbManager = new DBContext();
        Connection conn = null;
        PreparedStatement ps = null; //de nhan paramenter
        ResultSet rs = null;
        try {
            conn = dbManager.getConnection();
            ps = conn.prepareStatement(query);

            rs = ps.executeQuery();

            while (rs.next()) {
                Jobs job = new Jobs();
                job.setJobid(rs.getInt("job_ID"));
                job.setJobname(rs.getString("job_Name"));
                jobs.add(job);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return jobs;
    }
   
}
