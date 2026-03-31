(import /project/generator/system :as generator)
(import /project/camera/system :as camera)
(import /html/common :as c)
(import ./common-main :as cm)

(import spork/argparse :as ap)

(defn demo-run [console]) 

(def PROJ {"0" (partial demo-run) 
           "1" (partial generator/run)
           "2" (partial camera/run)})

(def my-projects [[0 "demo-run" true] 
                  [1 "generator" false] 
                  [2 "camera" false]]) 

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

