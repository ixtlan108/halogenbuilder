(import /project/derivatives/system :as derivatives)
(import /html/common :as c)
(import ./common-main :as cm)

(import spork/argparse :as ap)

(defn demo-run [console]) 

(def PROJ {"1" (partial derivatives/run)}) 

(def my-projects [[1 "derivatives" true]]) 

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

