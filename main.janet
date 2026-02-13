(import /project/generator/system :as generator)
(import /html/common :as c)
(import /html/input :as inp)


(def input-1 
  { :name "input1" 
    :type :num
    :title "Gps#"
    :evt "GpsChange"}) 

(defn main [&]
  (generator/run))
  #(map c/prn-result (inp/mk-content-std-num "GpsChange" "my-input-class" :num)))
  #(map c/prn-result (inp/make "MainAction" input-1)))

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


