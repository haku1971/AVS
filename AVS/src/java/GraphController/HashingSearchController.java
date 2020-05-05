/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package GraphController;

import Model.Algorithm;
import static GraphController.SearchStepServlet.tempArray;
import DAO.AlgorithmDAO;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author BinhNT
 */
@WebServlet(name = "HashingSearchController", urlPatterns = {"/HashingSearchController"})
public class HashingSearchController extends HttpServlet {

    static class HashEntry {

        private int key;

        private int value;

        HashEntry(int key, int value) {
            this.key = key;
            this.value = value;
        }

        public int getValue() {
            return value;
        }

        public void setValue(int value) {

            this.value = value;
        }

        public int getKey() {
            return key;
        }
    }

    static class DeletedEntry extends HashEntry {

        private static DeletedEntry entry = null;

        private DeletedEntry() {
            super(-1, -1);
        }

        public static DeletedEntry getUniqueDeletedEntry() {
            if (entry == null) {
                entry = new DeletedEntry();
            }
            return entry;
        }
    }

    static class HashMap {

      
        
        HashEntry[] table;

        HashMap() {
            table = new HashEntry[hashsize];
            for (int i = 0; i < hashsize; i++) {
                table[i] = null;
            }
        }

        public int get(int key) {

            int hash = (key % hashsize);

            int initialHash = -1;

            while (hash != initialHash && (table[hash] == DeletedEntry.getUniqueDeletedEntry()
                    || table[hash] != null && table[hash].getKey() != key)) {

                if (initialHash == -1) {
                    initialHash = hash;
                }

                hash = (hash + 1) % hashsize;

            }

            if (table[hash] == null || hash == initialHash) {
                return -1;
            } else {
                return table[hash].getValue();
            }

        }

        public int getaddressingstep(int key) {
            int count = 0;
            int hash = (key % hashsize);
            int initialHash = -1;                      
            while (hash != initialHash && (table[hash] == DeletedEntry.getUniqueDeletedEntry()
                    || table[hash] != null && table[hash].getKey() != key)) {      
                if (initialHash == -1) {
                    initialHash = hash;
                }
                count++;
                hash = (hash + 1) % hashsize;
            }

            if (table[hash] == null || hash == initialHash) {
                count++;
                return count;
            } else {
                count++;
                return count;
            }

        }

        public void put(int key, int value) {

            int hash = (key % hashsize);

            int initialHash = -1;

            int indexOfDeletedEntry = -1;

            while (hash != initialHash
                    && (table[hash] == DeletedEntry.getUniqueDeletedEntry() || table[hash] != null
                    && table[hash].getKey() != key)) {

                if (initialHash == -1) {
                    initialHash = hash;
                }

                if (table[hash] == DeletedEntry.getUniqueDeletedEntry()) {
                    indexOfDeletedEntry = hash;
                }

                hash = (hash + 1) % hashsize;

            }

            if ((table[hash] == null || hash == initialHash)
                    && indexOfDeletedEntry != -1) {
                table[indexOfDeletedEntry] = new HashEntry(key, value);
            } else if (initialHash != hash) {
                if (table[hash] != DeletedEntry.getUniqueDeletedEntry()
                        && table[hash] != null && table[hash].getKey() == key) {
                    table[hash].setValue(value);
                } else {
                    table[hash] = new HashEntry(key, value);
                }
            }

        }
    }

//separate chaining
    static class HashNode<K, V> {

        K key;
        V value;

        // Reference to next node 
        HashNode<K, V> next;

        // Constructor 
        public HashNode(K key, V value) {
            this.key = key;
            this.value = value;
        }
    }

// Class to represent entire hash table 
    static class Map<K, V> {

        // bucketArray is used to store array of chains 
        private ArrayList<HashNode<K, V>> bucketArray;

        // Current capacity of array list 
        private int numBuckets;

        // Current size of array list 
        private int size;

        // Constructor (Initializes capacity, size and 
        // empty chains. 
        public Map() {
            bucketArray = new ArrayList<>();
            numBuckets = hashsize;
            size = 0;

            // Create empty chains 
            for (int i = 0; i < numBuckets; i++) {
                bucketArray.add(null);
            }
        }

        public int size() {
            return size;
        }

        public boolean isEmpty() {
            return size() == 0;
        }

        // This implements hash function to find index 
        // for a key 
        private int getBucketIndex(K key) {
            int hashCode = key.hashCode();

            int index = hashCode % numBuckets;
            //  System.out.println("hashcode"+ index);
            return index;
        }

        // Method to remove a given key 
        public V remove(K key) {
            // Apply hash function to find index for given key 
            int bucketIndex = getBucketIndex(key);

            // Get head of chain 
            HashNode<K, V> head = bucketArray.get(bucketIndex);

            // Search for key in its chain 
            HashNode<K, V> prev = null;
            while (head != null) {
                // If Key found 
                if (head.key.equals(key)) {
                    break;
                }

                // Else keep moving in chain 
                prev = head;
                head = head.next;
            }

            // If key was not there 
            if (head == null) {
                return null;
            }

            // Reduce size 
            size--;

            // Remove key 
            if (prev != null) {
                prev.next = head.next;
            } else {
                bucketArray.set(bucketIndex, head.next);
            }

            return head.value;
        }

        // Returns value for a key 
        public V get(K key) {
            // Find head of chain for given key 
            int bucketIndex = getBucketIndex(key);
            HashNode<K, V> head = bucketArray.get(bucketIndex);

            // Search key in chain 
            while (head != null) {
                if (head.key.equals(key)) {

                    return head.value;
                }
                head = head.next;
            }

            // If key not found 
            return null;
        }

        public int getsearchstep(K key) {
            //separate chaining cout step
            // Find head of chain for given key 
            int bucketIndex = getBucketIndex(key);
            int countseparatechaining = 0;
            HashNode<K, V> head = bucketArray.get(bucketIndex);
            // Search key in chain 
            while (head != null) {
                if (head.key.equals(key)) {
                    countseparatechaining++;
                    return countseparatechaining;
                }
                countseparatechaining++;
                head = head.next;
            }

            // If key not found 
            return countseparatechaining;
        }

        // Adds a key value pair to hash 
        public void add(K key, V value) {
            // Find head of chain for given key 
            int bucketIndex = getBucketIndex(key);
            HashNode<K, V> head = bucketArray.get(bucketIndex);
            // Check if key is already present 
            while (head != null) {
                if (head.key.equals(key)) {
                    head.value = value;
                    return;
                }
                head = head.next;
            }

            // Insert key in chain 
            size++;
            head = bucketArray.get(bucketIndex);
            HashNode<K, V> newNode = new HashNode<K, V>(key, value);
            newNode.next = head;
            bucketArray.set(bucketIndex, newNode);
            // If load factor goes beyond threshold, then 
            // double hash table size 
            if ((1.0 * size) / numBuckets >= 0.7) {
                ArrayList<HashNode<K, V>> temp = bucketArray;
                bucketArray = new ArrayList<>();
                numBuckets = 2 * numBuckets;
                size = 0;
                for (int i = 0; i < numBuckets; i++) {
                    bucketArray.add(null);
                }

                for (HashNode<K, V> headNode : temp) {
                    while (headNode != null) {
                        add(headNode.key, headNode.value);
                        headNode = headNode.next;
                    }
                }
            }
        }
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

    private static int chooseHashingFunctionByAlgoID(int searchvalue, int choose_algoid, int[] array) {
        switch (choose_algoid) {
            case 11: {
                //separate chaining
                Map<Integer, Integer> map = new Map<>();
                for (int i = 0; i < array.length; i++) {
                    map.add(array[i], array[i]);
                }
                if (map.getsearchstep(searchvalue) == 0) {
                    return map.getsearchstep(searchvalue) + 1;
                } else {
                    return map.getsearchstep(searchvalue);
                }
            }
            case 12: { // open addressing
                HashMap hm = new HashMap();
                for (int i = 0; i < array.length; i++) {
                    hm.put(array[i], array[i]);
                }
                return hm.getaddressingstep(searchvalue);
            }
            default:
                return 0;

        }

    }
   static int hashsize = 11;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            //goi ve cai mang ma duoc js truyen di
            response.setContentType("application/json");
            response.setCharacterEncoding("utf-8");
            int hasharraysize = Integer.parseInt(request.getParameter("hasharraysize"));
            hashsize = hasharraysize;
            System.out.println("size is: " + hasharraysize + "size local " + hashsize);
            
            String json = request.getParameter("initarray");
            int searchvalue = Integer.parseInt(request.getParameter("searchvalue"));
            Gson parser = new Gson();
            int[] jsFileArray = toArray(json, parser);

            AlgorithmDAO dao = new AlgorithmDAO();
            int categoryid = 6;
            ArrayList<Algorithm> listAlgo = dao.getAlgosortbyID(categoryid);
            for (int i = 0; i < listAlgo.size(); i++) {
                int choose_algoid = listAlgo.get(i).getAlgoID();
                listAlgo.get(i).setNumber_of_step(chooseHashingFunctionByAlgoID(searchvalue, choose_algoid, tempArray(jsFileArray)));
            }

            String jsonData = parser.toJson(listAlgo);
            PrintWriter out = response.getWriter();

            try {
                out.println(jsonData);
            } finally {
                out.close();
            }

        } catch (Exception ex) {
            System.out.println(ex);
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
