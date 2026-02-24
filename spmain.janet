(import /project/generator/system :as generator)
(import /project/camera/system :as camera)
(import /html/common :as c)

(import spork/argparse :as ap)

(defn demo-run [console]) 

(defn proj-item [[index desc is-first]] 
  (if is-first
    (string/format "\n\n\t%d:\t%s" index desc)
    (string/format "%d:\t%s" index desc)))

(defn proj-help []
  (let [projs [[0 "demo-run" true] 
               [1 "generator" false] 
               [2 "camera" false]] 
        projsx (map proj-item projs)]
    (string/join projsx "\n\t")))

(def PROJ {"0" (partial demo-run) 
           "1" (partial generator/run)
           "2" (partial camera/run)})

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

