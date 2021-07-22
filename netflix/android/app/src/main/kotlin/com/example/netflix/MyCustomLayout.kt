package com.example.netflix

import android.content.Context
import android.content.Intent
import android.graphics.Color
import android.net.Uri
import android.util.Log
import android.view.Gravity
import android.view.ViewGroup
import android.widget.LinearLayout
import com.example.netflix.base.Constants
import com.example.netflix.base.view.MyEditText
import com.example.netflix.base.view.MyImageButton
import com.example.netflix.base.view.MyTextButton
import com.example.netflix.base.view.MyTextView
import com.example.netflix.base.view.extension.setMarginDirection
import com.example.netflix.base.view.extension.setSize
import com.example.netflix.base.view.extension.setColor



class MyCustomLayout(ctxt: Context) : LinearLayout(ctxt) {
    val TAG = "MyCustomLayout"


    override fun setSelected(selected: Boolean) {
        super.setSelected(selected)
        if (selected) {
            Log.d(TAG, "selected")
        } else {
            Log.d(TAG, "!selected")
        }
    }

    init {
        val params = LayoutParams(LayoutParams.MATCH_PARENT,ViewGroup.LayoutParams.MATCH_PARENT)
        this.layoutParams = params
        this.orientation = VERTICAL

        val textView = MyTextView(context, Constants.ID_1, "Rendered on a native Android view")
        this.addView(textView)

        val button1 = MyTextButton(ctxt, Constants.ID_2, " Clear RMS")
        this.addView(button1)

        val buttonRate = MyTextButton(ctxt, Constants.ID_3, " Rate App")
        this.addView(buttonRate)
        buttonRate.setOnClickListener {
            Log.d(TAG, "buttonRate.setOnClickListener")
            val myIntent = Intent(Intent.ACTION_VIEW)
            myIntent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            myIntent.data = Uri.parse("https://play.google.com/store/apps/details?id=com.vieon.tv")
            ctxt.startActivity(myIntent)
        }

        val button3 = MyTextButton(ctxt, Constants.ID_4, " Share App")
        this.addView(button3)

        val textEmail = MyTextView(context, Constants.ID_1, "Email")
        this.addView(textEmail)

        val editEmail = MyEditText(context, Constants.ID_5)
        this.addView(editEmail)

        val textPassword = MyTextView(context, Constants.ID_1, "Password")
        this.addView(textPassword)

        val editPassword = MyEditText(context, Constants.ID_5)
        this.addView(editPassword)

        val buttonLogin = MyTextButton(ctxt, Constants.ID_4, "Login")
        buttonLogin.setMarginDirection(horizontal = 100)
        buttonLogin.setColor(Color.BLUE)
        this.addView(buttonLogin)

        val button4 = MyImageButton(ctxt, Constants.ID_5, R.drawable.ic_google_pay)
        button4.setMarginDirection(horizontal = 100)

        val button5 = MyImageButton(ctxt, Constants.ID_5, R.drawable.ic_momo_512dp)
        button5.setMarginDirection(horizontal = 100)

        val linearLayout = LinearLayout(context);
        linearLayout.gravity = Gravity.CENTER_HORIZONTAL
        val linearLayoutParam = LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.WRAP_CONTENT)
        linearLayoutParam.topMargin = 30
        linearLayout.layoutParams = linearLayoutParam
        linearLayout.orientation = HORIZONTAL
        linearLayout.addView(button4)
        linearLayout.addView(button5)
        this.addView(linearLayout)

        val button8 = MyImageButton(ctxt, Constants.ID_5, R.mipmap.ic_launcher)
        button8.setSize(width=1000, height = 1000)
        button8.setMarginDirection(horizontal = 100)
        this.addView(button8)
    }
}