(import /html/common :as c)
(import /html/wrapper :as w)

(defn inp-type [typ]
  (case typ
    :string "InputText"
    :int "InputNumber"
    :num "InputNumber"))


(defn mk-content-str [evt class disabled]
  (let [class1 (if class class "form-control ps-input")]
    @[[5 "case val of"]
      [6 "Nothing ->"]
      (if disabled
        [7 (string/format "HH.input [HP.type_ InputText, HP.classes [ ClassName \"%s\" ], HE.onValueChange %s, HP.disabled true]" class1 evt)]
        [7 (string/format "HH.input [HP.type_ InputText, HP.classes [ ClassName \"%s\" ], HE.onValueChange %s]" class1 evt)])
      [6 "Just val1 ->"]
      (if disabled
        [7 (string/format "HH.input [HP.type_ InputText, HP.classes [ ClassName \"%s\" ], HE.onValueChange %s, HP.value val1, HP.disabled true]" class1 evt)]
        [7 (string/format "HH.input [HP.type_ InputText, HP.classes [ ClassName \"%s\" ], HE.onValueChange %s, HP.value val1]" class1 evt)])]))

(defn mk-content-num [evt class typ disabled]
  (let [class1 (if class class "form-control ps-input")
        typ-s (inp-type typ)]
    @[[5 "case val of"]
      [6 "Nothing ->"]
      (if disabled
        [7 (string/format "HH.input [HP.type_ %s, HP.classes [ ClassName \"%s\" ], HE.onValueChange %s, HP.disabled true]" typ-s class1 evt)]
        [7 (string/format "HH.input [HP.type_ %s, HP.classes [ ClassName \"%s\" ], HE.onValueChange %s]" typ-s class1 evt)])
      [6 "Just val1 ->"]
      (if disabled
        [7 (string/format "HH.input [HP.type_ %s, HP.classes [ ClassName \"%s\" ], HE.onValueChange %s, HP.value (show val1), HP.disabled true]" typ-s class1 evt)]
        [7 (string/format "HH.input [HP.type_ %s, HP.classes [ ClassName \"%s\" ], HE.onValueChange %s, HP.value (show val1)]" typ-s class1 evt)])]))

(defn mk-content (p)
  (let [typ (p :type)
        evt (p :evt)
        class (p :class)
        disabled (p :disabled)]
    (case typ 
      :string (mk-content-str evt class disabled)
      :int (mk-content-num evt class typ disabled)
      :num (mk-content-num evt class typ disabled))))
    

(defn fn-param [p]
  (let [typ (p :type)]
    (case typ
      :string ["val" "Maybe String"]
      :int ["val" "Maybe Int"]
      :num ["val" "Maybe Number"])))

(defn mk-sign [act p]
  (c/mk-fn-sign (p :name) act (fn-param p)))

(defn make [act p]
  (let [sign (mk-sign act p)
        cnt (mk-content p)
        wp (w/mk-wrapper-prm (p :title) :lc (p :lc) :sc (p :sc))] 
    (array/join sign (w/wrapper wp cnt)))) 
  
(defn mk-inp-fn [ma] (fn [b] (make ma b)))

(defn run-inputs [inputs action output-fn]
  (let [inp-fn (mk-inp-fn action)
        items (map inp-fn inputs)]
    (map output-fn items)))




(comment
  (defn mk-content (p)
    (let  [typ (inp-type p)
           evt (p :evt)
           class (p :class)
           p1 (p :p1)]
      (let [class1 (if class class "form-control ps-input")]
        (if p1
         (let [[val-name _] p1]
           (if (= (p :type) :string)
             @[[5 (string/format "HH.input [HP.type_ %s, HP.classes [ ClassName \"%s\" ], HE.onValueChange %s, HP.value %s ]" typ class1 evt val-name)]]
             @[[5 (string/format "HH.input [HP.type_ %s, HP.classes [ ClassName \"%s\" ], HE.onValueChange %s, HP.value (show %s) ]" typ class1 evt val-name)]]))
         @[[5 (string/format "HH.input [HP.type_ %s, HP.classes [ ClassName \"%s\" ], HE.onValueChange %s]" typ class1 evt)]])))))
