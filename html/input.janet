(import /html/common :as c)
(import /html/wrapper :as w)

(defn inp-type [typ]
  (case typ
    :string "InputText"
    :int "InputNumber"
    :num "InputNumber"))


(defn mk-str-1 [class evt]
  [7 (string/format "HH.input [HP.type_ InputText, HP.classes [ ClassName \"%s\" ], HE.onValueChange %s, HP.disabled true]" class evt)])

(defn mk-str-2 [class evt]
  [7 (string/format "HH.input [HP.type_ InputText, HP.classes [ ClassName \"%s\" ], HE.onValueChange %s]" class evt)])

(defn mk-str-3 [class]
  [7 (string/format "HH.input [HP.type_ InputText, HP.classes [ ClassName \"%s\" ], HP.disabled true]" class)])

(defn mk-str-4 [class]
  [7 (string/format "HH.input [HP.type_ InputText, HP.classes [ ClassName \"%s\" ]]" class)])

(defn mk-str-5 [class evt]
  [7 (string/format "HH.input [HP.type_ InputText, HP.classes [ ClassName \"%s\" ], HE.onValueChange %s, HP.value val1, HP.disabled true]" class evt)])

(defn mk-str-6 [class evt]
  [7 (string/format "HH.input [HP.type_ InputText, HP.classes [ ClassName \"%s\" ], HE.onValueChange %s, HP.value val1]" class evt)])

(defn mk-str-7 [class]
  [7 (string/format "HH.input [HP.type_ InputText, HP.classes [ ClassName \"%s\" ], HE.onValueChange %s, HP.value val1, HP.disabled true]" class)])

(defn mk-str-8 [class]
  [7 (string/format "HH.input [HP.type_ InputText, HP.classes [ ClassName \"%s\" ], HP.value val1]" class)])

(defn mk-content-str [class evt-disabled]
  (let [class1 (if class class "form-control ps-input")]
    @[[5 "case val of"]
      [6 "Nothing ->"]
      (match evt-disabled 
        [nil true] (mk-str-3 class1)
        [nil false] (mk-str-4 class1)
        [evt true] (mk-str-1 class1 evt)
        [evt false] (mk-str-2 class1 evt))
      [6 "Just val1 ->"]
      (match evt-disabled 
        [nil true] (mk-str-7 class1)
        [nil false] (mk-str-8 class1)
        [evt true] (mk-str-5 class1 evt)
        [evt false] (mk-str-6 class1 evt))]))

(defn mk-num-1 [typ-s class evt]
  [7 (string/format "HH.input [HP.type_ %s, HP.classes [ ClassName \"%s\" ], HE.onValueChange %s, HP.disabled true]" typ-s class evt)])

(defn mk-num-2 [typ-s class evt]
  [7 (string/format "HH.input [HP.type_ %s, HP.classes [ ClassName \"%s\" ], HE.onValueChange %s]" typ-s class evt)])

(defn mk-num-3 [typ-s class]
  [7 (string/format "HH.input [HP.type_ %s, HP.classes [ ClassName \"%s\" ], HP.disabled true]" typ-s class)])

(defn mk-num-4 [typ-s class]
  [7 (string/format "HH.input [HP.type_ %s, HP.classes [ ClassName \"%s\" ]]" typ-s class)])

(defn mk-num-5 [typ-s class evt]
  [7 (string/format "HH.input [HP.type_ %s, HP.classes [ ClassName \"%s\" ], HE.onValueChange %s, HP.value (show val1), HP.disabled true]" typ-s class evt)])

(defn mk-num-6 [typ-s class evt]
  [7 (string/format "HH.input [HP.type_ %s, HP.classes [ ClassName \"%s\" ], HE.onValueChange %s, HP.value (show val1)]" typ-s class evt)])

(defn mk-num-7 [typ-s class]
  [7 (string/format "HH.input [HP.type_ %s, HP.classes [ ClassName \"%s\" ], HP.disabled true, HP.value (show val1)]" typ-s class)])

(defn mk-num-8 [typ-s class]
  [7 (string/format "HH.input [HP.type_ %s, HP.classes [ ClassName \"%s\" ], HP.value (show val1)]" typ-s class)])

(defn mk-content-num [class typ evt-disabled]
  (let [class1 (if class class "form-control ps-input")
        typ-s (inp-type typ)]
    @[[5 "case val of"]
      [6 "Nothing ->"]
      (match evt-disabled 
        [nil true] (mk-num-3 typ-s class1)
        [nil false] (mk-num-4 typ-s class1)
        [evt true] (mk-num-1 typ-s class1 evt)
        [evt false] (mk-num-2 typ-s class1 evt))
      [6 "Just val1 ->"]
      (match evt-disabled 
        [nil true] (mk-num-7 typ-s class1)
        [nil false] (mk-num-8 typ-s class1)
        [evt true] (mk-num-5 typ-s class1 evt)
        [evt false] (mk-num-6 typ-s class1 evt))]))

(defn mk-content (p)
  (let [typ (p :type)
        evt (p :evt)
        class (p :class)
        disabled (p :disabled)]
    (case typ 
      :string (mk-content-str class [evt disabled])
      :int (mk-content-num class typ [evt disabled])
      :num (mk-content-num class typ [evt disabled]))))
    

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
