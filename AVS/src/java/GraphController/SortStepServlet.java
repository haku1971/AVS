/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package GraphController;

import Entity.Algorithm;
import Model.AlgorithmModel;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Quangnhse05858
 */
public class SortStepServlet extends HttpServlet {

    public static int selectionSort(int arr[]) {
        int count = 0;
        int n = arr.length;

        // One by one move boundary of unsorted subarray 
        for (int i = 0; i < n - 1; i++) {
            // Find the minimum element in unsorted array 
            int min_idx = i;
            for (int j = i + 1; j < n; j++) {
                if (arr[j] < arr[min_idx]) {
                    min_idx = j;
                    // Swap the found minimum element with the first 
                    // element 
                    int temp = arr[min_idx];
                    arr[min_idx] = arr[i];
                    arr[i] = temp;
                    count++;
                }
            }
        }
        return count;
    }

    public static int insertionSort(int arr[]) {
        int count = 0;
        int n = arr.length;
        for (int i = 1; i < n; ++i) {
            int key = arr[i];
            int j = i - 1;

            /* Move elements of arr[0..i-1], that are 
             greater than key, to one position ahead 
             of their current position */
            while (j >= 0 && arr[j] > key) {
                arr[j + 1] = arr[j];
                j = j - 1;
                count++;
            }
            arr[j + 1] = key;

        }
        return count;
    }

    public static int bubbleSort(int arr[]) {
        int n = arr.length;
        int count = 0;
        for (int i = 0; i < n - 1; i++) {
            for (int j = 0; j < n - i - 1; j++) {
                if (arr[j] > arr[j + 1]) {
                    // swap arr[j+1] and arr[i] 
                    int temp = arr[j];
                    arr[j] = arr[j + 1];
                    arr[j + 1] = temp;
                    count++;
                }
            }
        }
        return count;
    }

    /*
     protected void doGet(HttpServletRequest request, HttpServletResponse response, AlgoSort algo)
     throws ServletException, IOException {
     Gson gson = new Gson();
     String jsonData = gson.toJson(algo);
     // request.setAttribute(jsonData, jsonData);
     //  request.getRequestDispatcher("jsonjs.js").forward(request, response);
     PrintWriter out = response.getWriter();
     try {
     out.println(jsonData);
     } finally {
     out.close();
     }
     }
     */
    private static List<Integer> toList(String json, Gson parser) {
        return parser.fromJson(json, List.class);
    }

    private static int[] toArray(String json, Gson parser) {
        return parser.fromJson(json, int[].class);
    }

    int[] tempArray(int[] arr) {
        int[] newarr = new int[arr.length];

        for (int i = 0; i < arr.length; i++) {
            newarr[i] = arr[i];

        }
        return newarr;
    }

    private static int chooseSortFunctionByAlgoID(int number, int[] array) {
        switch (number) {
            case 1:
               return bubbleSort(array);
                            
            case 3:
               return  selectionSort(array);
               
            case 5:                
             return   insertionSort(array);
               
            default:
                return 0;

        }
     
    }

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            //goi ve cai mang ma duoc js truyen di
            response.setContentType("application/json");
            response.setCharacterEncoding("utf-8");
            String json = request.getParameter("name");
            Gson parser = new Gson();
            int[] jsFileArray = toArray(json, parser);

            AlgorithmModel dao = new AlgorithmModel();
   
            ArrayList<Algorithm> listAlgo = dao.getAlgosortbyID(1);
            for (int i = 0; i < listAlgo.size(); i++) {
                int choosefunctionkey = listAlgo.get(i).getAlgoID();        
                    listAlgo.get(i).setNumber_of_step(chooseSortFunctionByAlgoID(choosefunctionkey, tempArray(jsFileArray)));
            }
      
        String jsonData = parser.toJson(listAlgo);
        PrintWriter out = response.getWriter();

        try {
            out.println(jsonData);
        } finally {
            out.close();
        }

    }
    catch (Exception ex) 
    {Logger.getLogger(SortStepServlet.class.getName()).log(Level.SEVERE, null, ex);
    }

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
