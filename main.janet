(import /project/generator/system :as generator)
(import /project/rapanui/system :as rapanui)
(import /project/derivatives/system :as derivatives)
(import /html/common :as c)
#(import /html/input :as inp)
(import /html/select2 :as sel2)


(comment input-1 
  { :name "input1" 
    :type :num
    :title "Gps#"
    :evt "GpsChange"}) 

(defn run [] 
  (let [items {}])
  (map c/prn-result (sel2/mk-sign "demo" "MainAction"))
  (map c/prn-result (sel2/mk-content {:evt "Event" :disabled "false"})))

(defn main [&]
  (run))
  #(derivatives/run))
  #(rapanui/run))
  #(generator/run))
  #(rapanui/run))
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


