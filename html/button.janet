(import /html/common :as c)

(def class-map
  @{ :default "btn ps-btn btn-outline-success"
     :std-s1 "btn btn-outline-success ps-mt-auto"
     :std-s2 "btn btn-outline-success ps-mt-auto ps-mr-1"
     :std-d1 "btn btn-outline-danger ps-mt-auto"
     :std-d2 "btn btn-outline-danger ps-mt-auto ps-mr-1"
     :ps-s1  "btn ps-btn btn-outline-success ps-mt-auto ps-mr-1"
     :ps-s2  "btn ps-btn btn-outline-success ps-mt-auto ps-mr-1 ps-btn-150 "
     :ps-s3  "btn ps-btn btn-outline-success ps-mt-auto ps-mr-1 ps-btn-250 "})

(defn get-class [clazz]
  (if (nil? clazz)
    (get class-map :default)
    (if (= :keyword (type clazz))
      (get class-map clazz)
      clazz)))

(defn mk-content [btn]
  (let [evt (btn :evt)
        title (btn :title)
        class (btn :class)
        disopt (btn :disopt)]
    (if disopt
      [2 (string/format "HH.button [HE.onClick %s, HP.disabled isDisabled, HP.classes [ ClassName \"%s\"]] [HH.text \"%s\"]" evt class title)]
      [2 (string/format "HH.button [HE.onClick %s, HP.classes [ ClassName \"%s\"]] [HH.text \"%s\"]" evt class title)])))

(defn mk-sign [act btn]
  (if (btn :disopt)
    (c/mk-fn-sign (btn :name) act ["isDisabled" "Boolean"])
    (c/mk-fn-sign (btn :name) act)))

(defn make [act btn]
  (let [sign (mk-sign act btn)
        cnt (mk-content btn)]
    (array/push sign cnt)))

(defn mk-btn-fn [ma] (fn [b] (make ma b)))

(defn run [btns action output-fn]
  (let [btn-fn (mk-btn-fn action)
        items (map btn-fn btns)]
    (map output-fn items)))

(defn params [name title evt &keys {:c class :d disable-option}]
  (default disable-option false)
  { :evt evt 
    :title title 
    :name name 
    :disopt disable-option
    :class (get-class class)}) 

