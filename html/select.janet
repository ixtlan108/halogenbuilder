(import /html/common :as c)
(import /html/wrapper :as w)


(def sp "")

(defn mk-sign [fn-name main-action]
  @[[1 sp] 
    [1 (string/format "%s :: forall w r. { items :: SelectItems, selected :: String | r } -> HTML w %s" fn-name main-action)]
    [1 (string/format "%s p = " fn-name)]])

#emptySelectItem :: SelectItem
#emptySelectItem = { v: "", t: "-"}

(defn empty-select []
  @[[1 sp]
    [1 "emptySelectItem :: SelectItem"]
    [1 "emptySelectItem = { v: \"\", t: \"-\"}"]])

(defn mk-option [act]
  @[[1 sp]
    [1 (string/format "mkOption :: forall w. String -> SelectItem -> HTML w %s" act)]
    [1 "mkOption selected item ="]
    [2 "HH.option"]
    [3 "[ HP.value item.v"]
    [3 ", HP.selected (item.v == selected)]"]
    [3 "[ HH.text item.t ]"]])

(defn mk-content [p]
  (let  [evt (p :evt)
         class (p :class)
         disabled (p :disabled)]
    (let [class1 (if class class "form-control ps-select")]
       @[[5 "let"]
         [6 "opts = map (mkOption p.selected) (emptySelectItem : p.items)"]
         [5 "in"]
         [5 (string/format "HH.select")]
         [6 (string/format "[ HP.classes [ ClassName \"%s\" ]" class1)]
         (if disabled
          (do
            [6 (string/format ", HE.onValueChange %s" evt)]
            [6 (string/format ", HP.disabled true ]")])
          [6 (string/format ", HE.onValueChange %s ]" evt)])
         [6 "opts"]])))

(defn make [act p]
  (let [sign (mk-sign (p :name) act)
        cnt (mk-content p)
        wp (w/mk-wrapper-prm (p :title) :lc (p :lc) :sc (p :sc))] 
    (array/join sign (w/wrapper wp cnt)))) 

(defn mk-sel-fn [ma] (fn [b] (make ma b)))

(defn run [selects action output-fn]
  (let [sel-fn (mk-sel-fn action)
        items (map sel-fn selects)]
    (map output-fn items)))

(defn params [name title evt &keys {:lc label-class :c class :d disabled}]
  (default disabled false)
  (default label-class "ps-label ps-mr-1")
  (default class "form-control ps-select")
  { :name name 
    :title title 
    :evt evt 
    :disabled disabled 
    :lc label-class 
    :class class})


