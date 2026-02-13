(import /html/button :as btn)
(import /html/wrapper :as wr)
(import /html/input :as inp)


  
(def input-1 
  { :name "input1" 
    :type :string
    :title "Gps#"
    :evt "GpsChanged" 
    :p1 ["myval" "String"] 
    :class "my-input-class"})

(def btn-1 
  { :evt "Btn1Click"
    :title "My btn-1 click"
    :disabled false
    :class "ps-btn btn btn-outline-success"
    :name "button1"})

(defn prn-result [s]
  (let [[level s1] s]
    (case level
      1 (print (string/format "  %s" s1)) 
      2 (print (string/format "    %s" s1)) 
      3 (print (string/format "      %s" s1)) 
      4 (print (string/format "        %s" s1)) 
      (print (string/format "      %s" s1))))) 


(defn main [&]
  (map prn-result (btn/make btn-1 "MainAction")))

(comment
  (defn main [&]
    (let [sign (inp/mk-sign input-1 "MainAction") 
          x @[(inp/mk-content input-1)]
          wp (wr/mk-wrapper-prm "My awesome input!" :lc "sfs-class sfs werwws")
          result (wr/wrapper wp x)]
         b (btn/mk-sign btn-1 "MainAction")
     (map print sign)
     (map prn-result result)
     (map print b))))


