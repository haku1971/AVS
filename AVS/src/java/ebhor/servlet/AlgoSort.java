/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ebhor.servlet;

/**
 *
 * @author Quangnhse05858
 */
public class AlgoSort {
    String sortName;
    int number_of_step;

    public AlgoSort() {
    }

    public AlgoSort(String sortName, int number_of_step) {
        this.sortName = sortName;
        this.number_of_step = number_of_step;
    }
    
    
    public String getSortName() {
        return sortName;
    }

    public void setSortName(String sortName) {
        this.sortName = sortName;
    }

    public int getNumber_of_step() {
        return number_of_step;
    }

    public void setNumber_of_step(int number_of_step) {
        this.number_of_step = number_of_step;
    }

    
    
}
