(import /project/generator/system :as generator)
#(import /project/rapanui/system :as rapanui)
(import /project/derivatives/system :as derivatives)
(import /html/common :as c)
#(import /html/input :as inp)
(import /html/select2 :as sel2)
(import /html/select :as sel)

(import spork/argparse :as ap)


(comment input-1 
  { :name "input1" 
    :type :num
    :title "Gps#"
    :evt "GpsChange"}) 

(def selects  
  @[{ :name "pwfGpsNum" 
      :title "GPS# - numeric"
      :evt "PwfGpsChange"
      :options [{:v "1" :t "V1" :f true} {:v "2" :t "V2"} {:v "3" :t "V3"}]
      :disabled "false"
      :skip-no-sel true}
    { :name "pwfGpsAlphaNum" 
      :title "GPS# - alphanumeric"
      :evt "PwfGpsChange"
      :disabled "false"
      :skip-no-sel true 
      :options [{:v "-" :t "" :f true} {:v "1" :t "V1"} {:v "2" :t "V2"} {:v "3" :t "V3"}]
      :class "form-control ps-select"}])

(defn demo-run [] 
  (let [result (sel2/with-no-select (first selects))]
    (print (type result))
    (printf "%q" result)))

(def PROJ {"x" (partial demo-run) 
           "1" (partial derivatives/run)})

(defn run [argx]
  (printf "%q" argx)
  (let [cmd (PROJ (argx "proj"))
        console (argx "console")]
    (cmd console)))
  
(defn main [&]
  (let
    [ argx (ap/argparse "Halogen Builder"
            "proj" {:kind :option  
                    :short "p" 
                    :help "x: Demo run, 1: derivatives" 
                    :required true}
            "console"  { :kind :flag    
                         :short "c" 
                         :default false 
                         :help "Write to console. Default: false"})]
    (if (not= argx nil)
      (run argx))))

  #(run))
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


