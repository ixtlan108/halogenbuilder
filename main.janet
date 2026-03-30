(import /project/derivatives/system :as derivatives)
(import /html/common :as c)

(import spork/argparse :as ap)

(defn demo-run [console]) 

(defn proj-item [[index desc is-first]] 
  (if is-first
    (string/format "\n\n\t%d:\t%s" index desc)
    (string/format "%d:\t%s" index desc)))

(defn proj-help []
  (let [projs [[1 "derivatives" true]] 
        projsx (map proj-item projs)]
    (string/join projsx "\n\t")))

(def PROJ {"1" (partial derivatives/run)}) 

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
                    :help (proj-help) 
                    :required true}
            "console"  { :kind :flag    
                         :short "c" 
                         :default false 
                         :help "Write to console. Default: false"})]
    (if (not= argx nil)
      (run argx))))

