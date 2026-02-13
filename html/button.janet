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
        disabled (btn :disabled)
        class (get-class btn)]
    (if disabled
      [2 (string/format "HH.button [HE.onClick %s, HP.disabled true, HP.classes [ ClassName \"%s\"]] [HH.text \"%s\"]" evt class title)]
      [2 (string/format "HH.button [HE.onClick %s, HP.classes [ ClassName \"%s\"]] [HH.text \"%s\"]" evt class title)])))

(defn mk-sign [btn act]
  (c/mk-fn-sign (btn :name) act))

(defn make [btn act]
  (let [sign (mk-sign btn act)
        cnt (mk-content btn)]
    (array/push sign cnt)))

#        cnt [2 (mk-content btn)]]
#    (array/push sign cnt)))
