(import /html/common :as c)

(def class-map
 @{ :default "ps-btn btn btn-outline-success"
    :1 "btn btn btn-outline-success ps-mt-auto"})

(defn get-class [btn]
  (let [class (btn :class)]
    (if (nil? class)
      (get class-map :default)
      (if (= :keyword (type class))
        (get class-map class)
        class))))

(defn mk-content [btn]
  (let [evt (btn :evt)
        title (btn :title)
        p1 (btn :p1)
        class (get-class btn)]
    (if p1
      (let [[val-name _] p1]
        [2 (string/format "HH.button [HE.onClick %s, HP.disabled %s, HP.classes [ ClassName \"%s\"]] [HH.text \"%s\"]" evt val-name class title)])
      [2 (string/format "HH.button [HE.onClick %s, HP.classes [ ClassName \"%s\"]] [HH.text \"%s\"]" evt class title)])))

(defn mk-sign [act btn]
  (let [p1 (btn :p1)]
    (if p1
      (c/mk-fn-sign (btn :name) act p1)
      (c/mk-fn-sign (btn :name) act))))

(defn make [act btn]
  (let [sign (mk-sign act btn)
        cnt (mk-content btn)]
    (array/push sign cnt)))

(defn mk-btn-fn [ma] (fn [b] (make ma b)))

(defn run-buttons [btns action output-fn]
  (let [btn-fn (mk-btn-fn action)
        items (map btn-fn btns)]
    (map output-fn items)))

    #(map (fn [b] (map c/prn-result b)) items)))

#        cnt [2 (mk-content btn)]]
#    (array/push sign cnt)))
