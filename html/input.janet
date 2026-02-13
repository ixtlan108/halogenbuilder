(import /html/common :as c)
(import /html/wrapper :as w)

(defn inp-type (p)
  (let  [typ (p :type)]
    (case typ
      :string "InputText"
      :int "InputNumber"
      :num "InputNumber")))

(defn mk-content (p)
  (let  [typ (inp-type p)
         evt (p :evt)
         class (p :class)
         p1 (p :p1)]
    (let [class1 (if class class "form-control ps-input")]
      (if p1
       (let [[val-name _] p1]
         [4 (string/format "HH.input [HP.type_ %s, HP.classes [\"%s\"], HE.onValueChange %s, HP.value %s ]" typ class1 evt val-name)])
       [4 (string/format "HH.input [HP.type_ %s, HP.classes [\"%s\"], HE.onValueChange %s]" typ class1 evt)]))))

(defn mk-sign [p act]
  (c/mk-fn-sign (p :name) act (p :p1)))
