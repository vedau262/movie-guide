package com.example.netflix.base.view

import android.content.Context
import android.graphics.Color
import android.graphics.drawable.GradientDrawable
import android.util.TypedValue
import android.view.Gravity
import android.view.ViewGroup
import android.widget.EditText
import android.widget.RelativeLayout
import com.example.netflix.R

class MyEditText(context: Context, id: Int) : EditText(context){
    private val textHeight = 150
    //    private val verticalMargin = resources.getDimensionPixelSize(R.dimen.dp_20)
    private val verticalMargin = 20

    init {
        val param = RelativeLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, textHeight)
        param.topMargin =verticalMargin
        param.bottomMargin =verticalMargin
        this.layoutParams = param
        this.id = id
        this.setTextSize(TypedValue.COMPLEX_UNIT_PX, resources.getDimension(R.dimen.sp_20))
        this.gravity = Gravity.START
        this.setBackgroundResource(R.drawable.button_transparent_gray)
        val drawable: GradientDrawable = this.getBackground() as GradientDrawable
        drawable.setColor(Color.WHITE)
        this.setTextColor(Color.BLACK)
    }
}