package com.example.netflix.base.view

import android.content.Context
import android.graphics.Color
import android.view.ViewGroup
import android.widget.Button
import android.widget.RelativeLayout
import com.example.netflix.R
import com.example.netflix.base.view.extension.setColor


class MyTextButton(context: Context, id: Int, textLabel: String) : Button(context) {
    private val verticalMargin = 20
    private val horizontalMargin = 0
    private val buttonHeight = 150

    init {
        val param = RelativeLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, buttonHeight)
        param.topMargin =verticalMargin
        param.bottomMargin =verticalMargin
        param.leftMargin = horizontalMargin
        param.rightMargin = horizontalMargin
        this.layoutParams = param
        this.text = textLabel
        this.id = id
        this.textSize = 20F
        this.setBackgroundResource(R.drawable.bg_rectangle_radius_16dp)
        this.setColor(Color.RED)
        this.setTextColor(Color.WHITE)
    }
}

