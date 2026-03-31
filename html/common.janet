
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

(defn mk-fn-sign-0 [fn-name main-action]
  @[[1 sp]
    [1 (string/format "%s :: forall w. HTML w %s" fn-name main-action)]
    [1 (string/format "%s =" fn-name)]])

(defn mk-fn-sign-1 [fn-name main-action p1]
  (let [[n1 t1] p1]
    @[[1 sp]
      [1 (string/format "%s :: forall w. %s -> HTML w %s" fn-name t1 main-action)]
      [1 (string/format "%s %s =" fn-name n1)]]))

(defn mk-fn-sign-2 [fn-name main-action p1 p2]
  (let [[n1 t1] p1
        [n2 t2] p2]
    @[[1 sp]
      [1 (string/format "%s :: forall w. %s -> %s -> HTML w %s" fn-name t1 t2 main-action)]
      [1 (string/format "%s %s %s =" fn-name n1 n2)]]))

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
      8 (print (string/format "              %s" s1)) 
      9 (print (string/format "                %s" s1)) 
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
      8 (file/write f (string/format "              %s\n" s1)) 
      9 (file/write f (string/format "                %s\n" s1)) 
      (file/write f (string/format "    %s\n" s1))))) 

(defn mk-write-fn [f] (fn [b] (write-result f b)))

(defn flatten [arr]
  (reduce array/join (array/new 8) arr))

(defn mk-output-fn1 [&opt f]
  (if f 
     (partial write-result f)
     prn-result))

(defn mk-output-fn2 [&opt f]
  (if f
    (let [wr-fn (partial write-result f)]
      (fn [b] (map wr-fn b)))
    (fn [b] (map prn-result b))))

(def output-root "/home/rcs/opt/java/harborview3/purescript")
#(def output-root "/home/rcs/opt/klaxton/PhotoAppMVC/Purescript")
#(def output-root "/Users/zeus/Projects/PhotoAppMVC/Purescript")

(defn localized [project-path]
  (string/format "%s/%s" output-root project-path))

(defn run [console run1 fname]
  (if console
    (let [out-2 (mk-output-fn2)
          out-1 (mk-output-fn1)]
      (run1 out-1 out-2))
    (let [f (file/open fname :w)
          out-2 (mk-output-fn2 f)
          out-1 (mk-output-fn1 f)]
      (run1 out-1 out-2)
      (file/close f))))


#(defn partial [f & args]
#  (fn [& more-args]
#    (apply f (array/concat args more-args)))



#(def add-two (partial + 2))
#(add-two 3)  ; => 5    
