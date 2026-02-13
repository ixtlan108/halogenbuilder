
(def sp "")

(defn mk-fn-sign [fn-name main-action &opt p1]
  (if p1 
    (let [[n1 t1] p1]
      @[[1 sp] 
        [1 (string/format "%s :: forall w. %s -> HTML w %s" fn-name t1 main-action)]
        [1 (string/format "%s %s =" fn-name n1)]])
    @[[1 sp]
      [1 (string/format "%s :: forall w. HTML w %s" fn-name main-action)]
      [1 (string/format "%s =" fn-name)]]))

(defn prn-result [s]
  (let [[level s1] s]
    (case level
      1 (print (string/format "%s" s1)) 
      2 (print (string/format "  %s" s1)) 
      3 (print (string/format "    %s" s1)) 
      4 (print (string/format "      %s" s1)) 
      5 (print (string/format "        %s" s1)) 
      6 (print (string/format "          %s" s1)) 
      7 (print (string/format "            %s" s1)) 
      (print (string/format "    %s" s1))))) 

(defn write-result [f s]
  (let [[level s1] s]
    (case level
      1 (file/write f (string/format "%s\n" s1)) 
      2 (file/write f (string/format "  %s\n" s1)) 
      3 (file/write f (string/format "    %s\n" s1)) 
      4 (file/write f (string/format "      %s\n" s1)) 
      5 (file/write f (string/format "        %s\n" s1)) 
      6 (file/write f (string/format "          %s\n" s1)) 
      7 (file/write f (string/format "            %s\n" s1)) 
      (file/write f (string/format "    %s\n" s1))))) 

(defn mk-write-fn [f] (fn [b] (write-result f b)))

#(defn partial [f & args]
#  (fn [& more-args]
#    (apply f (array/concat args more-args)))



#(def add-two (partial + 2))
#(add-two 3)  ; => 5    
