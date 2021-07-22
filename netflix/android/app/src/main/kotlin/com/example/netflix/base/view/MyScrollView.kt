package com.example.netflix.base.view

import android.content.Context
import android.graphics.Color
import android.view.ViewGroup
import android.widget.LinearLayout
import android.widget.ScrollView
import com.example.netflix.R
import com.example.netflix.base.view.extension.setColor

class MyScrollView(context: Context) : ScrollView(context){
    val topMargin = resources.getDimensionPixelSize(R.dimen.dp_30)
    val bottomMargin = resources.getDimensionPixelSize(R.dimen.dp_20)
    val leftMargin = resources.getDimensionPixelSize(R.dimen.dp_20)
    val rightMargin = resources.getDimensionPixelSize(R.dimen.dp_20)
    val padding = resources.getDimensionPixelSize(R.dimen.dp_20)
    init {

        this.setBackgroundResource(R.drawable.button_transparent_gray)
        this.setColor(Color.WHITE)
        val params = LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT)
        params.topMargin = topMargin
        params.bottomMargin = bottomMargin
        params.leftMargin = leftMargin
        params.rightMargin = rightMargin
        this.setPadding(padding,padding,padding,padding)
        this.layoutParams = params
    }
}