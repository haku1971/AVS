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
import java.util.Arrays;
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
                count++;
                if (arr[j] < arr[min_idx]) {
                    min_idx = j;
                }
                // Swap the found minimum element with the first 
                // element 

            }
            int temp = arr[min_idx];
            arr[min_idx] = arr[i];
            arr[i] = temp;

        }
        return count;
    }
    static int countquicksort = 0;

    static int partition(int array[], int low, int high) {

        int pivot = array[high];
        int i = (low - 1);

        for (int j = low; j < high; j++) {
            if (array[j] <= pivot) {
                i++;
                int temp = array[i];
                array[i] = array[j];
                array[j] = temp;
                countquicksort++;
            }
        }

        int temp = array[i + 1];
        array[i + 1] = array[high];
        array[high] = temp;
        countquicksort++;
        return (i + 1);
    }

    static void quickSort(int array[], int low, int high) {
        if (low < high) {
            int pi = partition(array, low, high);
            quickSort(array, low, pi - 1);
            quickSort(array, pi + 1, high);
        }

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
                count++;
                arr[j + 1] = arr[j];
                j = j - 1;

            }
            count++;
            arr[j + 1] = key;

        }
        return count;
    }

    public static int bubbleSort(int arr[]) {
        int n = arr.length;
        int count = 0;
        for (int i = 0; i < n - 1; i++) {
            for (int j = 0; j < n - i - 1; j++) {
                count++;
                if (arr[j] > arr[j + 1]) {
                    // swap arr[j+1] and arr[i] 
                    int temp = arr[j];
                    arr[j] = arr[j + 1];
                    arr[j + 1] = temp;

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
    // A utility function to get maximum value in arr[] 
    static int getMax(int arr[], int n) {
        int max = arr[0];
        for (int i = 1; i < n; i++) {
            if (arr[i] > max) {
                max = arr[i];
            }
        }
        return max;
    }

    // A function to do counting sort of arr[] according to 
    // the digit represented by exp. 
    static void countRadixSort(int arr[], int n, int exp) {
        int output[] = new int[n]; // output array 
        int i;
        int counter[] = new int[10];
        Arrays.fill(counter, 0);
        // Store count of occurrences in count[] 
        for (i = 0; i < n; i++) {
            counter[(arr[i] / exp) % 10]++;
        }
        // Change count[i] so that count[i] now contains 
        // actual position of this digit in output[] 
        for (i = 1; i < 10; i++) {
            counter[i] += counter[i - 1];
        }
        // Build the output array 
        for (i = n - 1; i >= 0; i--) {
            countradixsort++;
            output[counter[(arr[i] / exp) % 10] - 1] = arr[i];
            counter[(arr[i] / exp) % 10]--;
        }
        // Copy the output array to arr[], so that arr[] now 
        // contains sorted numbers according to curent digit 
        for (i = 0; i < n; i++) {
            countradixsort++;
            arr[i] = output[i];
        }
    }

    // The main function to that sorts arr[] of size n using 
    // Radix Sort 
    static void radixsort(int arr[], int n) {
        // Find the maximum number to know number of digits 
        int max = getMax(arr, n);
        // Do counting sort for every digit. Note that instead 
        // of passing digit number, exp is passed. exp is 10^i 
        // where i is current digit number 
        for (int exp = 1; max / exp > 0; exp *= 10) {
            countRadixSort(arr, n, exp);
        }
    }

    // Main function that sorts arr[l..r] using 
    // merge() 
    static void merge(int arr[], int l, int m, int r) {
        // Find sizes of two subarrays to be merged 
        int n1 = m - l + 1;
        int n2 = r - m;
        /* Create temp arrays */
        int L[] = new int[n1];
        int R[] = new int[n2];
        /*Copy data to temp arrays*/
        for (int i = 0; i < n1; ++i) {
            L[i] = arr[l + i];
        }
        for (int j = 0; j < n2; ++j) {
            R[j] = arr[m + 1 + j];
        }
        /* Merge the temp arrays */
        // Initial indexes of first and second subarrays 
        int i = 0, j = 0;
        // Initial index of merged subarry array 
        int k = l;

        while (i < n1 && j < n2) {
            countmerge++;
            if (L[i] <= R[j]) {
                arr[k] = L[i];
                i++;
            } else {
                arr[k] = R[j];
                j++;
            }
            k++;
        }
        /* Copy remaining elements of L[] if any */
        while (i < n1) {
            countmerge++;
            arr[k] = L[i];
            i++;
            k++;

        }
        /* Copy remaining elements of R[] if any */
        while (j < n2) {
            countmerge++;
            arr[k] = R[j];
            j++;
            k++;

        }

    }

    static void mergesort(int arr[], int l, int r) {
        if (l < r) {
            // Find the middle point           
            int m = (l + r) / 2;
            // Sort first and second halves 
            mergesort(arr, l, m);
            mergesort(arr, m + 1, r);
            // Merge the sorted halves 
            merge(arr, l, m, r);
        }
    }

    public static void heapsort(int arr[]) {
        int n = arr.length;

        // Build heap (rearrange array) 
        for (int i = n / 2 - 1; i >= 0; i--) {
            heapify(arr, n, i);
        }
        // One by one extract an element from heap 
        for (int i = n - 1; i > 0; i--) {
            // Move current root to end 
            int temp = arr[0];
            arr[0] = arr[i];
            arr[i] = temp;

            // call max heapify on the reduced heap 
            heapify(arr, i, 0);
        }
    }

    // To heapify a subtree rooted with node i which is 
    // an index in arr[]. n is size of heap 
    static void heapify(int arr[], int n, int i) {
        countheap++;
        int largest = i; // Initialize largest as root 
        int l = 2 * i + 1; // left = 2*i + 1 
        int r = 2 * i + 2; // right = 2*i + 2 
        //System.out.println("r goc " +r);

        // If left child is larger than root 
        if (l < n && arr[l] > arr[largest]) {
            largest = l;
        }

        // If right child is larger than largest so far 
        if (r < n && arr[r] > arr[largest]) {
            //       System.out.println("arr r" +arr[r]);
            largest = r;
        }
        // If largest is not root 
        if (largest != i) {

            int swap = arr[i];
            arr[i] = arr[largest];
            arr[largest] = swap;

            // Recursively heapify the affected sub-tree 
            heapify(arr, n, largest);
        }
    }

    /* A utility function to print array of size n */
    static void printArray(int arr[]) {
        int n = arr.length;
        for (int i = 0; i < n; ++i) {
            System.out.print(arr[i] + " ");
        }
        System.out.println();
    }

    static int countmerge = 0;
    static int countheap = 0;
    static int countradixsort = 0;

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
            case 2:
                quickSort(array, 0, array.length - 1);
                return countquicksort;
            case 3:
                return selectionSort(array);
            case 4: {
                heapsort(array);
                return countheap;
            }
            case 5:
                return insertionSort(array);
            case 6: {
                mergesort(array, 0, array.length - 1);
                return countmerge;
            }
            case 7: {
                radixsort(array, array.length);
                return countradixsort;
            }
            default:
                return 0;

        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            countquicksort = 0;
            countheap = 0;
            countmerge = 0;
            countradixsort = 0;
            //goi ve cai mang ma duoc js truyen di
            response.setContentType("application/json");
            response.setCharacterEncoding("utf-8");
            String json = request.getParameter("name");
            Gson parser = new Gson();
            int[] jsFileArray = toArray(json, parser);

            AlgorithmDAO dao = new AlgorithmDAO();

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
