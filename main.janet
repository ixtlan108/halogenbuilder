(import /project/derivatives/system :as derivatives)
(import /html/common :as c)
(import ./common-main :as cm)


(defn not-implemented [console]
  (print "NOT IMLEMENTED"))

(import spork/argparse :as ap)

(defn demo-run [console]) 

(def PROJ {"1" (partial not-implemented) 
           "2" (partial not-implemented) 
           "3" (partial not-implemented) 
           "4" (partial derivatives/run)}) 

(def my-projects [[1 "rapanui" true] 
                  [2 "maunaloa" false] 
                  [3 "optionpurchase" false] 
                  [4 "derivatives" false]]) 

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
                    :help (cm/proj-help my-projects) 
                    :required true}
            "console"  { :kind :flag    
                         :short "c" 
                         :default false 
                         :help "Write to console. Default: false"})]
    (if (not= argx nil)
      (run argx))))

