package GoginsChapters.ScoreManager;
// This is a part of the Microsoft Visual J++ library.
// Copyright (C) 1996 Microsoft Corporation
// All rights reserved.

//package java.awt;

import java.util.Hashtable;
import java.awt.LayoutManager;
import java.awt.Component;
import java.awt.Container;
import java.awt.Dimension;
import java.awt.Rectangle;
import java.awt.FontMetrics;
import java.awt.Insets;
import java.awt.Label;

//
// class DialogLayout
//
// DialogLayout is a simple layout manager which works with what the Win32
// API calls "dialog logical units" (DLUs).  DLUs are resolution independent
// coordinates which work well for laying out controls on a dialog box.  The
// mapping from DLUs to pixels is based on the font in use in the dialog box.
// An x-coordinate DLU is described as 1/4 (.25) of the of the average character
// width of the font used in the dialog.  A y-coordinate DLU is described as
// 1/8 (.125) of the character height used in the dialog.  One tricky issue to
// note: The average character width is not the average of all characters --
// rather it is the average of all alpha characters both uppercase and
// lowercase. That is, it is the extent of the string "a...zA...Z" divided
// by 52.
//
// This class allows you to associate a Rectangle (x, y, width, height) with a
// Component in a Container.  If called upon to layout the container, this
// layout manager will layout based on the translation of dialog units to
// pixels.
//

public class DialogLayout
	implements LayoutManager
{
	protected Hashtable m_map = new Hashtable();
	protected int m_width;
	protected int m_height;

	// DialogLayout methods

	public DialogLayout(Container parent, int width, int height)
	{
		Construct(parent, width, height);
	}

	public DialogLayout(Container parent, Dimension d)
	{
		Construct(parent, d.width, d.height);
	}

	public void setShape(Component comp, int x, int y, int width, int height)
	{
		m_map.put(comp, new Rectangle(x, y, width, height));
	}

	public void setShape(Component comp, Rectangle rect)
	{
		m_map.put(comp, new Rectangle(rect.x, rect.y, rect.width, rect.height));
	}

	public Rectangle getShape(Component comp)
	{
		Rectangle rect = (Rectangle)m_map.get(comp);
		return new Rectangle(rect.x, rect.y, rect.width, rect.height);
	}

	public Dimension getDialogSize()
	{
		return new Dimension(m_width, m_height);
	}

	// LayoutManager Methods

	public void addLayoutComponent(String name, Component comp) { }
	public void removeLayoutComponent(Component comp) { }

	public Dimension preferredLayoutSize(Container parent)
	{
		return new Dimension(m_width, m_height);
	}

	public Dimension minimumLayoutSize(Container parent)
	{
		return new Dimension(m_width, m_height);
	}

	public void layoutContainer(Container parent)
	{
		int count = parent.countComponents();
		Rectangle rect = new Rectangle();
		int charHeight = getCharHeight(parent);
		int charWidth = getCharWidth(parent);
		Insets insets = parent.insets();
		FontMetrics m = parent.getFontMetrics(parent.getFont());
		
		for (int i = 0; i < count; i++)
		{
			Component c = parent.getComponent(i);
			Rectangle r = (Rectangle)m_map.get(c);
			if (r != null)
			{
				rect.x = r.x;
				rect.y = r.y;
				rect.height = r.height;
				rect.width = r.width;
				mapRectangle(rect, charWidth, charHeight);
				if (c instanceof Label)
				{
					// Adjusts for space at left of Java labels.
					rect.x     -= 12;
					rect.width += 12;
				}

				rect.x += insets.left;
				rect.y += insets.top;
				c.reshape(rect.x, rect.y, rect.width, rect.height);
			}
		}
	}

	// Implementation Helpers

	protected void Construct(Container parent, int width, int height)
	{
		Rectangle rect = new Rectangle(0, 0, width, height);
		mapRectangle(rect, getCharWidth(parent), getCharHeight(parent));
		m_width = rect.width;
		m_height = rect.height;
	}

	protected int getCharWidth(Container parent)
	{
		FontMetrics m = parent.getFontMetrics(parent.getFont());
		String s     = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
		int    width = m.stringWidth(s) / s.length();

		if (width <= 0)
			width = 1;
		return width;
	}

	protected int getCharHeight(Container parent)
	{
		FontMetrics m = parent.getFontMetrics(parent.getFont());
		int height = m.getHeight();
		return height;
	}

	protected void mapRectangle(Rectangle rect, int charWidth, int charHeight)
	{
		rect.x      = (rect.x      * charWidth)  / 4;
		rect.y      = (rect.y      * charHeight) / 8;
		rect.width  = (rect.width  * charWidth)  / 4;
		rect.height = (rect.height * charHeight) / 8;
	}
}

