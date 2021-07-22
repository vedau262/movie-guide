package com.example.netflix.base.view

import android.content.Context
import android.view.ViewGroup
import android.widget.ImageButton
import android.widget.RelativeLayout

class MyImageButton(context: Context, id: Int, backgroundResource: Int) : ImageButton(context) {
    private val verticalMargin = 0
    private val horizontalMargin = 0

    init {
        val param = RelativeLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT)
        param.topMargin =verticalMargin
        param.bottomMargin =verticalMargin
        param.leftMargin = horizontalMargin
        param.rightMargin = horizontalMargin
        this.layoutParams = param
        this.id = id
        this.setBackgroundResource(backgroundResource)
    }
}