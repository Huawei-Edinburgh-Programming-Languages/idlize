class %COMPONENT_ATTRIBUTE_NAME%StyleHolder {
    var value: ?((attributes: %STYLE_PARAMETER_TYPE%) -> Unit)
    init (value: ?((attributes: %STYLE_PARAMETER_TYPE%) -> Unit)) {
        this.value = value
    }
}

class %COMPONENT_ATTRIBUTE_NAME%ContentHolder {
    var value: ?(() -> Unit)
    init (value: ?(() -> Unit)) {
        this.value = value
    }
}


@Memo
public func Ark%COMPONENT_NAME%(
    style: ?((attributes: %STYLE_PARAMETER_TYPE%) -> Unit),
    content_: ?(() -> Unit)%FUNCTION_PARAMETERS%
): Unit {
    let styleHolder = %COMPONENT_ATTRIBUTE_NAME%StyleHolder(style)
    let contentHolder = %COMPONENT_ATTRIBUTE_NAME%ContentHolder(content_)
    let receiver = remember({ => %COMPONENT_CLASS_NAME%() })
    NodeAttach<%PEER_CLASS_NAME%>({ => %PEER_CLASS_NAME%.create(receiver, 0) }) {
        %PEER_CALLABLE_INVOKE%
        if (let Some(style) <- styleHolder.value) {
            style(receiver)
        }
        if (let Some(content_) <- contentHolder.value) {
            content_()
        }
    }
}
