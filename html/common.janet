
(defn mk-fn-sign [fn-name main-action &opt p1]
  (if p1 
    (let [[n1 t1] p1]
      @[[1 (string/format "%s :: forall w. %s -> HTML w %s" fn-name t1 main-action)]
        [1 (string/format "%s =" fn-name)]])
    @[[1 (string/format "%s :: forall w. HTML w %s" fn-name main-action)]
      [1 (string/format "%s =" fn-name)]]))
