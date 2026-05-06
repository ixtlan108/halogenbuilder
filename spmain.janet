(import /project/generator/system :as generator)
(import /project/camera/system :as camera)
(import /project/klaxtonlog/system :as klaxtonlog)
(import /project/crm/customer/system :as cust)

(import /html/common :as c)
(import /html/checkbox :as cb)
(import ./common-main :as cm)

(import spork/argparse :as ap)

(defn run1 [out-1]
  (map out-1 cust/billing-address)

 (comment [p (cb/content-params "id1" "OnCheckClick" "Hey you!")]
       cnt (cb/mk-content p)
   (map out-1 cnt)))

(def fname (c/localized "crm/customer-crm/src/CustomerCRM/UI2.purs"))

(defn demo-run [console] 
  (c/run-fn1 console run1 fname))


(def PROJ {"0" (partial demo-run) 
           "1" (partial generator/run)
           "2" (partial camera/run)
           "3" (partial klaxtonlog/run)
           "4" (partial cust/run)})

(def my-projects [[0 "demo-run" true] 
                  [1 "generator" false] 
                  [2 "camera" false] 
                  [3 "log" false] 
                  [4 "crm/customer" false]]) 

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

