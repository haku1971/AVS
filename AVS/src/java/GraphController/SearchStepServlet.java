/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package GraphController;

import Model.Algorithm;
import DAO.AlgorithmDAO;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author quang
 */
public class SearchStepServlet extends HttpServlet {

    static int interpolationSearch(int arr[], int searchvalue) {
        // Find indexes of two corners 
        int low = 0, high = (arr.length - 1);
        int count = 0;

        while (low <= high && searchvalue >= arr[low] && searchvalue <= arr[high]) {
            if (low == high) {
                count++;
                if (arr[low] == searchvalue) {
                    return count;
                }
                return count;
            }

            // Probing the position with keeping 
            // uniform distribution in mind. 
//            int pos = (int) (low + ((float)((float)(high - low)
//                    / (float)(arr[high] - arr[low])) * (searchvalue - arr[low])));
            int pos = (int) (low + (((double)(high - low) / 
                    (arr[high] - arr[low])) * (searchvalue - arr[low]))); 

            count++;
            // Condition of target found 
            if (arr[pos] == searchvalue) {
                return count;
            }

            // If x is larger, x is in upper part 
            if (arr[pos] < searchvalue) {
                low = pos + 1;
            } // If x is smaller, x is in the lower part 
            else {
                high = pos - 1;
            }
        }
        return count;

    }

    public static int linearsearch(int arr[], int searchvalue) {
        int count = 0;
        int n = arr.length;
        for (int i = 0; i < n; i++) {
            if (arr[i] == searchvalue) {
                count++;
                return count;
            }
            count++;
        }
        return count;
    }

    static int binarySearch(int arr[], int left, int right, int searchvalue, int count) {
        count++;
        if (right >= left) {
            int mid = left + (right - left) / 2;

            // If the element is present at the 
            // middle itself 
            if (arr[mid] == searchvalue) {

                return count;
            }

            // If element is smaller than mid, then 
            // it can only be present in left subarray 
            if (arr[mid] > searchvalue) {
                return binarySearch(arr, left, mid - 1, searchvalue, count);
            } // Else the element can only be present 
            // in right subarray 
            else {
                return binarySearch(arr, mid + 1, right, searchvalue, count);
            }
        }

        // We reach here when element is not present 
        // in array 
        return count;
    }

    private static int[] toArray(String json, Gson parser) {
        return parser.fromJson(json, int[].class);
    }

     static int[] tempArray(int[] arr) {

        int[] newarr = new int[arr.length];
        for (int i = 0; i < arr.length; i++) {
            newarr[i] = arr[i];

        }
        return newarr;
    }

    static int[] bubbleSort(int arr[]) {
        int[] newarr = tempArray(arr);
        int n = arr.length;
        for (int i = 0; i < n - 1; i++) {
            for (int j = 0; j < n - i - 1; j++) {
                if (newarr[j] > newarr[j + 1]) {
                    // swap arr[j+1] and arr[i] 
                    int temp = newarr[j];
                    newarr[j] = newarr[j + 1];
                    newarr[j + 1] = temp;
                }
            }
        }
        return newarr;
    }

    private static int chooseSortFunctionByAlgoID(int searchvalue, int choose_algoid, int[] array) {
        switch (choose_algoid) {
            case 8:
                return linearsearch(array, searchvalue);

            case 9:
                //array, left,right, searchvalue,count
                return binarySearch(bubbleSort(array), 0, array.length - 1, searchvalue, 0);

            case 10:
                return interpolationSearch(array, searchvalue);

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
            String json = request.getParameter("initarray");
            int searchvalue = Integer.parseInt(request.getParameter("searchvalue"));
            Gson parser = new Gson();
            int[] jsFileArray = toArray(json, parser);

            AlgorithmDAO dao = new AlgorithmDAO();
            int categoryid = 5;
            ArrayList<Algorithm> listAlgo = dao.getAlgosortbyID(categoryid);
            for (int i = 0; i < listAlgo.size(); i++) {
                int choose_algoid = listAlgo.get(i).getAlgoID();
                listAlgo.get(i).setNumber_of_step(chooseSortFunctionByAlgoID(searchvalue, choose_algoid, tempArray(jsFileArray)));
            }

            String jsonData = parser.toJson(listAlgo);
            PrintWriter out = response.getWriter();

            try {
                out.println(jsonData);
            } finally {
                out.close();
            }

        } catch (Exception ex) {
            Logger.getLogger(SortStepServlet.class.getName()).log(Level.SEVERE, null, ex);
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
